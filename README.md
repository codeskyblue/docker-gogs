docker-gogs
===========

docker file for gogits

still testing

```
git pull codeskyblue/docker-gogs
git clone https://github.com/codeskyblue/docker-gogs.git
cd docker-gogs
docker run -P -d -p 10022:22 -p 13000:3000 -v data:/srv/gogs/data codeskyblue:docker-gogs
```

mysql setting

1. username: root
2. password: toor
