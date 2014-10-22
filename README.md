docker-gogs
===========

Dockerfile for [gogs](http://gogs.io) server(a self-hosted git service).

## Usage
```
git pull codeskyblue/docker-gogs

mkdir /var/gogs
docker run -d -p 22:22 -p 3000:3000 -v /var/gogs:/data codeskyblue/docker-gogs
```

Open bowser and naviage to

```
http://youhost:3000
```

* Config file in /var/gogs/gogs/conf/app.ini
* git repo in /var/gogs/git

It's ok to change /var/gogs to other directory.

## Test
ssh(port 22) is not passed test yet. So git clone git@.. not supported.

