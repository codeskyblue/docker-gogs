#!/bin/bash
#

service ssh start

if ! test -d /data/gogs
then	
	mkdir -p /var/run/sshd
	mkdir -p /data/gogs/data /data/gogs/conf /data/gogs/log /data/git
fi

test -d /data/gogs/templates || cp -ar ./templates /data/gogs/

ln -sf /data/gogs/log ./log
ln -sf /data/gogs/data ./data
ln -sf /data/git /home/git

rsync -rtv /data/gogs/templates/ ./templates/

chown -R git:git /data .
exec su git -c "./gogs web"
