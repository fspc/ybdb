# YBDB

**BikeBike Docker Container Image for Yellow Bike Dabtabase**

Yellow Bike [Project's](http://austinyellowbike.org) Hours and Transaction [Database](http://austinyellowbike.org/about/special-projects/yellow-bike-hours-and-transaction-database/).

Heavily developed [YBP Devel](https://github.com/fspc/Yellow-Bike-Database/tree/devel) is being utilized.

## Pull the repository

```
docker pull bikebike/ybdb
```

## Run the docker container

Publish the container's port to the host:

>format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort


```
docker run -d -p 81:80 --name="ybdb" bikebike/ybdb
```

### Status

Moving along nicely!

## How to test/develop inside the running container process 

```
sudo docker exec -it ybdb /bin/bash
```

If it produces this error:

```
rpc error: code = 13 desc = invalid header field value "oci runtime error: exec failed: container_linux.go:247: starting container process caused \"process_linux.go:75: starting setns process caused \\\"fork/exec /proc/self/exe: no such file or directory\\\"\"\n"
```

then do this before attempting again:


```
docker stop ybdb
docker start ybdb
```
