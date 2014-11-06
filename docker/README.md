st2docker
=========

To play around with this docker image, docker must be installed on your system.

## Steps
* Git clone this repo to your box.
```git clone git@github.com:StackStorm/st2docker.git```

* Build st2 docker image.
```docker build -t st2 .```

* Run a container with the image.
```docker run -it st2```

* Run start.sh inside container.
```/root/st2/start.sh```

* Play around with st2.
```st2 --version```
