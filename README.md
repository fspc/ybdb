#YBDB

**BikeBike Docker Container Image for Yellow Bike Dabtabase**

Yellow Bike [Project's](http://austinyellowbike.org) Hours and Transaction [Database](http://austinyellowbike.org/about/special-projects/yellow-bike-hours-and-transaction-database/).

Heavily developed [YBP Devel](https://github.com/fspc/Yellow-Bike-Database/tree/devel) is being utilized.

##Pull the repository

```
docker pull bikebike/ybdb
```

##Run the docker container

Publish the container's port to the host:

>format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort


```
docker run -d -p 81:80 --name="ybdb" bikebike/ybdb
```

###Status

Moving along nicely!

##How to test/develop inside the running container process 

This method uses [nsenter](http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/).  Check out [jpetazzo/nsenter](https://github.com/jpetazzo/nsenter) on GitHub. 

```
sudo PID=$(docker inspect --format {{.State.Pid}} <container_name_or_ID>)
sudo nsenter --target $PID --mount --uts --ipc --net --pid
```
