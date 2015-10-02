# st2docker

# DEPRECATION NOTICE

This project has been *DEPRECATED*. Please refer to the following pages for updated instructions on accessing StackStorm via:

* Vagrant: http://docs.stackstorm.com/install/all_in_one.html#vagrant 
* Docker: http://docs.stackstorm.com/install/docker.html


This repository contains Dockerfile which allows run all the StackStorm
services in a single docker container.

All the services are running inside a single container which means this method
is good for testing and developing StackStorm, but not appropriate for
production where "one service per container" model should be followed.

## Requirements

To play around with this docker image, docker must be installed on your system.

## Steps

* Git clone this repo to your boxL

```bash
git clone https://github.com/StackStorm/st2express.git
```

* Change in to docker directory:

```bash
cd st2express/docker
```

* Build st2 docker image:

```bash
docker build -t st2 .
```

* Run a container with the image:

```bash
docker run -it st2
```

* Run start.sh inside container:

```bash
/root/st2/start.sh
```

* Play around with st2:

```bash
st2 --version
```

For more information please refer to the documentation -
http://docs.stackstorm.com/

## Using a specific version of StackStorm

By default, Dockerfile always uses the latest available stable version of
StackStorm.

If you want to use a specific version of, edit ``Dockerfile`` and change the
following line:

```
RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/scripts/st2_deploy.sh
```

To point to a deployment script for a specific version. For example:

```
RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/0.7.0/st2_deploy.sh
```
