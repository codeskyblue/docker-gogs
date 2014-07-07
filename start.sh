#!/bin/bash

# upstart workaround
dpkg-divert --local --rename --add /sbin/initctl
ln -s /bin/true /sbin/initctl

# start SSH
mkdir -p /var/run/sshd
/usr/sbin/sshd

# Link MySQL dir to /srv/gogs/data
mv /var/lib/mysql /var/lib/mysql-tmp
ln -s /srv/gogs/data/mysql /var/lib/mysql

ln -s /src/gogs/data/git /home/git

# start mysql
mysqld_safe &

/home/git/gogs/start.sh &>/var/log/gogs.log &

# keep script in foreground
tail -f /var/log/gogs.log
