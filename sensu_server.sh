#!/bin/bash

RABBIT_PUBLIC_KEY="rabbitmq-signing-key-public.asc"

prereqs(){

  wget http://www.rabbitmq.com/${RABBIT_PUBLIC_KEY}
  sudo apt-key add ${RABBIT_PUBLIC_KEY}
  rm ${RABBIT_PUBLIC_KEY}

  wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -

  if [ ! -f /etc/apt/sources.list.d/rabbit.list ]
  then
   echo 'deb  http://www.rabbitmq.com/debian/ testing main' >> /etc/apt/sources.list.d/rabbit.list
  fi
  if [ ! -f /etc/apt/sources.list.d/sensu.list ]
  then
    echo "deb http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list
  fi
  apt-get update
}

install_redis(){
  apt-get -y install redis-server
}

install_rabbitmq() {
#    # Install rabbitmq
#    apt-get -y install rabbitmq-server
#    # enable rabbitmq-management plugin
    rabbitmq-plugins enable rabbitmq_management
    # Restart rabbitmq
    service rabbitmq-server restart
    # use rabbitmqctl to check status
    rabbitmqctl status
    # rabbitmaadmin is useful to inspect exchanges, queues etc.
    curl http://localhost:15672/cli/rabbitmqadmin >> /usr/bin/rabbitmqadmin
    chmod 755 /usr/bin/rabbitmqadmin
    mkdir -p /etc/rabbitmq/ssl
    cp -f /vagrant/sensu/ssl_certs/sensu_ca/cacert.pem /etc/rabbitmq/ssl/
    cp -f /vagrant/sensu/ssl_certs/server/cert.pem /etc/rabbitmq/ssl/
    cp -f /vagrant/sensu/ssl_certs/server/key.pem /etc/rabbitmq/ssl/
    cp /vagrant/sensu/rabbitmq.config /etc/rabbitmq/
    service rabbitmq-server restart
    rabbitmqctl add_vhost /sensu
    rabbitmqctl add_user sensu sensu
    rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
}

install_sensu() {
  apt-get -y install sensu
}

install_dashboard(){
  apt-get -y install uchiwa
}

configure_sensu(){
  mkdir -p /etc/sensu/ssl
  cp -f /vagrant/sensu/ssl_certs/client/cert.pem /etc/sensu/ssl/
  cp -f /vagrant/sensu/ssl_certs/client/key.pem /etc/sensu/ssl/

  cp /vagrant/sensu/redis.json /etc/sensu/conf.d/
  cp /vagrant/sensu/api.json /etc/sensu/conf.d/
  cp -f /vagrant/sensu/uchiwa.json /etc/sensu/

  chown -R sensu:sensu /etc/sensu

  update-rc.d sensu-server defaults
  update-rc.d sensu-api defaults
  update-rc.d uchiwa defaults
}

start_sensu(){
  service sensu-server restart
  service sensu-api restart
  service uchiwa restart
}

prereqs
install_redis
install_rabbitmq
install_sensu
install_dashboard
configure_sensu
start_sensu

