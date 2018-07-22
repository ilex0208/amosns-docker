# Depracation Notice

## amosns (Docker Image)

amosns is a private npm repository server

### Installing Image

`docker pull ilex_h/amosns:latest`

### Creating Container

`docker run --name amosns -d -p 9696:9696 ilex_h/amosns`

### Setting Registry

`npm set registry http://<docker_host>:9696/`

### Determining Username and Password

`docker logs amosns`

### Modify configuration

There are two ways to modify the configuration.

### Original Method

```
docker stop amosns
docker run --volumes-from amosns -it --rm ubuntu vi /opt/amosns/config.yaml
docker start amosns
```

### Alternative Method

```bash
# Save the config file
curl -L https://raw.githubusercontent.com/ilex_h/amosns/master/conf/default.yaml -o /path/to/config.yaml
# Mount the config file to the exposed data volume
docker run -v /path/to/config.yaml:/opt/amosns/config.yaml --name amosns -d -p 9696:9696 ilex_h/amosns:latest
```

Restart the container anytime you change the config.

### configure Vagrant

Setting the npm registry to `http://localhost:9696` in a Dockerfile which should point to the amosns registry locally will not work during the `docker build` process, since localhost:9696 references to the Docker container itself and not the host-machine where amosns runs.
With the Vagrant configuration one could locally spin up this Dockerfile in a vbox with the command `vagrant up` and reference this registry it in a 'target'-Dockerfile with `RUN npm set registry http://10.10.10.10:9696`.

```bash
# vagrant up
```

and in the Dockerfile of your application set

```bash
CMD npm set registry http://10.10.10.10:9696
```

[Vagrant](https://en.wikipedia.org/wiki/Vagrant_\(software\)) is open source. See install instructions for [mac](http://sourabhbajaj.com/mac-setup/Vagrant/README.html) or [\*nix](http://www.olindata.com/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts).

### Backups

`docker run --volumes-from amosns -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /opt/amosns`

Alternatively, host path for /opt/amosns can be determined by running:

`docker inspect amosns`

### Restore

```bash
docker stop amosns
docker rm amosns
docker run --name amosns -d -p 9696:9696 ilex_h/amosns:latest
docker stop amosns
docker run --volumes-from amosns -v $(pwd):/backup ubuntu tar xvf /backup/backup.tar
docker start amosns
```

## Links

