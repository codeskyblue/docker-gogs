#!/bin/bash

# upstart workaround
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# start SSH
mkdir -p /var/run/sshd
/usr/sbin/sshd

ln -s /src/gogs/data/repositories /home/git/gogs-repositories
rm -R /home/git/.ssh && ln -s /srv/gogs/data/ssh /home/git/.ssh && chown -R git:git /srv/gogs/data/ssh && chmod -R 0700 /srv/gogs/data/ssh && chmod 0700 /home/git/.ssh
chown -R git:git /srv/gogs/data/repositories
rm -fr /home/git/gogs/conf && ln -s /srv/gogs/data/conf /home/git/gogs/conf && chown -R git:git /srv/gogs/data/conf

/home/git/gogs/start.sh &>/var/log/gogs.log &

# keep script in foreground
tail -f /var/log/gogs.log
