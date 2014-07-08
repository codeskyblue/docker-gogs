docker-gogs
===========

docker file for gogits

still testing

```
git clone https://github.com/codeskyblue/docker-gogs.git
cd docker-gogs
docker -P -d -p 10022:22 -p 13000:3000 -v data:/srv/gogs/data codeskyblue:docker-gogs
```

mysql setting

1. username: root
2. password: toor
