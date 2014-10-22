#!/bin/bash
#

service ssh start

test -d /data/gogs || mkdir -p /var/run/sshd && \
	mkdir -p /data/gogs/data /data/gogs/conf /data/gogs/log /data/git && \
	ln -s /data/gogs/log ./log && \
	ln -s /data/gogs/data ./data && \
	ln -s /data/git /home/git && \
	chown -R git:git /data .

su git -c "./gogs web"
