#!/bin/bash
HOSTNAME=`hostname`
IPADDR=`ifconfig | grep -A1 'eth1' | grep -A1 'inet addr' | cut -d ':' -f 2 | cut -d ' ' -f 1`

prereqs(){

  wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -

  if [ ! -f /etc/apt/sources.list.d/sensu.list ]
  then
    echo "deb http://repos.sensuapp.org/apt sensu main" > /etc/apt/sources.list.d/sensu.list
  fi
  apt-get update
}

install_sensu() {
  apt-get -y install sensu
  apt-get install -y ruby ruby-dev build-essential
  gem install sensu-plugin
}

configure_sensu(){
  mkdir -p /etc/sensu/ssl
  cp -f /vagrant/sensu/ssl_certs/client/cert.pem /etc/sensu/ssl/
  cp -f /vagrant/sensu/ssl_certs/client/key.pem /etc/sensu/ssl/

  cp /vagrant/sensu/rabbitmq.json /etc/sensu/conf.d/rabbitmq.json
  cp /vagrant/sensu/client.json /etc/sensu/conf.d/client.json
  sed -i "s/HOSTNAME_HERE/${HOSTNAME}/g" /etc/sensu/conf.d/client.json
  sed -i "s/IPADDR_HERE/${IPADDR}/g" /etc/sensu/conf.d/client.json
  chown -R sensu:sensu /etc/sensu

  update-rc.d sensu-client defaults
}

start_sensu(){
  service sensu-client restart
}

prereqs
install_sensu
configure_sensu
start_sensu

