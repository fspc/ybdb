# YBDB

**BikeBike Docker Container Image for Yellow Bike Dabtabase**

Yellow Bike [Project's](http://austinyellowbike.org) Hours and Transaction [Database](http://austinyellowbike.org/about/special-projects/yellow-bike-hours-and-transaction-database/).

Heavily developed [YBP Devel](https://github.com/fspc/Yellow-Bike-Database/tree/devel) is being utilized.

## How to Use

The recommended way is to run `docker-compose up -d`. By default, your container will be available on port 88.

## Advanced environmental changes
The docker-compose.yml file looks for a file called environment.  I enjoy using [docker-letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion), so here is what I add, after changing `port` in docker-compose.yml from `88:80` to `80`:

###### environment
```
VIRTUAL_HOST=ybdb.bikelover.org
LETSENCRYPT_HOST=ybdb.bikelover.org
LETSENCRYPT_EMAIL="jr@bikelover.org"
```

## Old Fashioned way

If you do not want to use docker-compose, you may pull the repository:

```
docker pull bikebike/ybdb
```

Then run the docker container:

Publish the container's port to the host:

>format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort


```
docker run -d -p 88:80 --name="ybdb" bikebike/ybdb
```

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
