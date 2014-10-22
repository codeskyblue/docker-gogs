docker-gogs
===========

docker file for gogits

```
git pull codeskyblue/docker-gogs:latest

mkdir /var/gogs
docker run --rm -p 22:22 -p 80:3000 -v /var/gogs:/data codeskyblue:docker-gogs
```

If need to run background
```
docker run -d --rm -p 22:22 -p 80:3000 -v /var/gogs:/data codeskyblue@docker-gogs
```
