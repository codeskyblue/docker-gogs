docker-gogs
===========

docker file for gogits

```
git pull codeskyblue/docker-gogs

mkdir /var/gogs
docker run --rm -p 22:22 -p 80:3000 -v /var/gogs:/data codeskyblue/docker-gogs
```

If need to run background

```
docker run -d --rm -p 22:22 -p 80:3000 -v /var/gogs:/data codeskyblue/docker-gogs
```

## detail
ssh(port 22) is not passed test.

config file is in /var/gogs/gogs/conf/app.ini
