FROM ubuntu:13.10
MAINTAINER ciarand <code@ciarand.me>

RUN apt-get update

# Install dependencies
RUN apt-get -y install git mercurial wget curl tar openssh-server zip ca-certificates build-essential

# Create Git user
RUN adduser --disabled-login --gecos 'gogits' git

# Install Go
RUN mkdir -p /goproj
ENV PATH /usr/local/go/bin:/goproj/bin:$PATH
ENV GOROOT /usr/local/go
ENV GOPATH /goproj

RUN wget -q http://golang.org/dl/go1.3.src.tar.gz -O- | tar -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

# Install Gogs
RUN go get -tags sqlite -d github.com/gogits/gogs
RUN cd /goproj/src/github.com/gogits/gogs; \
  git checkout -b v0.4.2;\
  go get -v -tags sqlite

RUN cp -r /goproj/src/github.com/gogits/gogs /home/git;\
  cp /goproj/bin/gogs /home/git/gogs/;\
  chown -R git:git /home/git/gogs;

EXPOSE 22
EXPOSE 3000

ADD . /app
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
