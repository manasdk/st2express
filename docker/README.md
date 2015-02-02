# st2docker

To play around with this docker image, docker must be installed on your system.

## Steps

* Git clone this repo to your box.
```git clone https://github.com/StackStorm/st2express.git```

* Change in to docker directory
```cd st2express/docker```

* Build st2 docker image.
```docker build -t st2 .```

* Run a container with the image.
```docker run -it st2```

* Run start.sh inside container.
```/root/st2/start.sh ```

* Play around with st2.
```st2 --version```

## Using a specific version of StackStorm

If you want to use a specific version of StackStorm, edit ``Dockerfile`` and
change the following line:

```
RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/scripts/st2_deploy.sh
```

To point to a deployment script file for a specific version, for example:

```
RUN cd /root && curl -sS -k -O https://ops.stackstorm.net/releases/st2/0.7.0/st2_deploy.sh
```
