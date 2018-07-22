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
