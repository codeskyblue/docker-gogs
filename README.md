docker-gogs
===========

Dockerfile for [gogs](http://gogs.io) server(a self-hosted git service).

>This repo have been combined into <https://github.com/gogits/gogs> in 2015-08-17.

Since the offcial repo got too many issues. Issue about docker gogs can still submit here.

## Usage
```
docker pull gogs/gogs

mkdir -p /var/gogs
docker run --name=gogs -d -p 10022:22 -p 10080:3000 -v /var/gogs:/data gogs/gogs
```

More details can be found in <https://github.com/gogits/gogs/tree/master/docker>

### Link with mysql
mysql is from <https://registry.hub.docker.com/_/mysql/>.

**Alert**. Not tested. For my machine got too low memory, and canot run mysql. 

If you are interested to test. Pull request are welcome. pr to <https://github.com/gogits/gogs> branch: develop

First start an mysql instance

	docker pull mysql
	docker run --name gogs-mysql -e MYSQL_DATABASE=gogs -e MYSQL_ROOT_PASSWORD=abcd -d mysql

Then run gogs

	mkdir -p /var/gogs
	docker run --rm -ti --name gogs --link gogs-mysql:mysql -p 10022:22 -p 10080:3000 -v /var/gogs:/data codeskyblue/docker-gogs

Good luck.
