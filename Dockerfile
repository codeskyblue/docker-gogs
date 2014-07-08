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
RUN cd /home/git;\
  su git -c "git clone https://github.com/gogits/gogs.git -b v0.4.2";\
  cd gogs; go get -v;\
  cp /goproj/bin/gogs .;\
  echo "clone ok"
  
EXPOSE 22
EXPOSE 3000

ADD . /srv/gogs
RUN chmod +x /srv/gogs/start.sh

CMD ["/srv/gogs/start.sh"]
