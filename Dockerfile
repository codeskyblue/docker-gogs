FROM google/golang
MAINTAINER codeskyblue@gmail.com

RUN apt-get install -y openssh-server

# grab but do not build gogs
RUN git clone https://github.com/gogits/gogs.git /gopath/src/github.com/gogits/gogs

# set the working directory and add current stuff
WORKDIR /gopath/src/github.com/gogits/gogs
RUN git checkout master
RUN go get -v -tags sqlite
RUN go build -tags sqlite
ADD . /gopath/src/github.com/gogits/gogs

RUN useradd --system --comment gogits git

# prepare data
ENV GOGS_CUSTOM /data/gogs

EXPOSE 22 3000
ENTRYPOINT []
CMD ["./start.sh"]
