FROM ubuntu:12.04
ENV MYSQLTMPROOT temprootpass

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
RUN add-apt-repository -y ppa:git-core/ppa;\
  apt-get update;\
  apt-get -y install git curl tar

# Install Go
RUN mkdir -p /goproj
ENV PATH /usr/local/go/bin:/go/bin:$PATH
ENV GOROOT /usr/local/go
ENV GOPATH /goproj
ENV GOBIN /home/git/gogs

RUN curl -s http://golang.org/dl/go1.3.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

# Install Gogs
RUN cd /home/git;\
  su git -c "git clone https://github.com/gogits/gogs.git -b v0.4.2";\
  cd gogs; go get -v;\
  echo "clone ok"
  
EXPOSE 22
EXPOSE 3000

ADD . /srv/gogs
RUN chmod +x /srv/gogs/start.sh

CMD ["/srv/gogs/start.sh"]
