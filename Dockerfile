FROM ubuntu:12.04
MAINTAINER  codeskyblue <codeskyblue@gmail.com>

ENV MYSQLTMPROOT toor

RUN apt-get update

# Install dependencies
RUN apt-get install -y openssh-server

# Install MySQL
RUN echo mysql-server mysql-server/root_password password $MYSQLTMPROOT | debconf-set-selections;\
  echo mysql-server mysql-server/root_password_again password $MYSQLTMPROOT | debconf-set-selections;\
  apt-get install -y mysql-server mysql-client libmysqlclient-dev

# Create Git user
RUN adduser --disabled-login --gecos 'gogits' git

# Install Git
RUN apt-get -y install git wget tar

# Clean all the unused packages
RUN apt-get autoremove -y

# Install Go
RUN mkdir -p /goproj
ENV PATH /usr/local/go/bin:/goproj/bin:$PATH
ENV GOROOT /usr/local/go
ENV GOPATH /goproj

RUN wget -q http://golang.org/dl/go1.3.src.tar.gz -O- | tar -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

# Install Gogs
RUN go get -d github.com/gogits/gogs
RUN cd /goproj/src/github.com/gogits/gogs; \
  git checkout -b v0.4.2;\
  go get -v

RUN cp -r /goproj/src/github.com/gogits/gogs /home/git;\
  cp /goproj/bin/gogs /home/git/gogs/;\
  chown -R git:git /home/git/gogs;
  
EXPOSE 22
EXPOSE 3000

ADD . /srv/gogs
RUN chmod +x /srv/gogs/start.sh

CMD ["/srv/gogs/start.sh"]
