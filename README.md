docker-gogs
===========

Dockerfile for [gogs](http://gogs.io) server(a self-hosted git service).

>This repo have been combined into <https://github.com/gogits/gogs> in 2015-08-17.

Since the offcial repo got too many issues. Issue about docker gogs can still submit here.

## Usage
```
docker pull codeskyblue/docker-gogs

mkdir -p /var/gogs
docker run --name=gogs -d -p 10022:22 -p 10080:3000 -v /var/gogs:/data codeskyblue/docker-gogs
```

Open bowser and naviage to

```
http://yourhost:10080
```

ssh port listens on 10022

It's ok to change `/var/gogs` to other directory.

Directory `/var/gogs` keeps git and gogs data

	/var/gogs
	├── git
	│   └── gogs-repositories
	|-- ssh
	|    `-- # ssh pub-pri keys for gogs
	└── gogs
		├── conf
		├── data
		├── log
		└── templates

Config file is in `gogs/conf/app.ini`

If your store engine choose sqlite, then the data file is in `gogs/data/gogs.db`

### Support ssh
After finish the gogs install. Another step need to do to support **ssh**. (Wait the gogs offical update the install page)

edit gogs/conf/app.ini

Add `SSH_PORT = 10022` after `[server]`

For example:

```
[server]
DOMAIN = git.shengxiang.me
HTTP_PORT = 3000
ROOT_URL = http://git.shengxiang.me/
SSH_PORT = 10022
```

Then restart gogs by run `docker restart gogs`

### Link with mysql
mysql is from <https://registry.hub.docker.com/_/mysql/>.

**Alert**. Not tested. For my machine got too low memory, and canot run mysql. 

If you are interested to test. Pull request are welcome.

First start an mysql instance

	docker pull mysql
	docker run --name gogs-mysql -e MYSQL_DATABASE=gogs -e MYSQL_ROOT_PASSWORD=abcd -d mysql

Then run gogs

	mkdir -p /var/gogs
	docker run --rm -ti --name gogs --link gogs-mysql:mysql -p 10022:22 -p 10080:3000 -v /var/gogs:/data codeskyblue/docker-gogs

Good luck.
