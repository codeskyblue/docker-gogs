FROM google/golang

# grab but do not build gogs
RUN mkdir -p /gopath/src/github.com/gogits
RUN git clone https://github.com/gogits/gogs.git /gopath/src/github.com/gogits/gogs

# set the working directory and add current stuff
WORKDIR /gopath/src/github.com/gogits/gogs
RUN git checkout v0.4.2
RUN go get -v -tags sqlite
RUN go build -tags sqlite
ADD . /gopath/src/github.com/gogits/gogs

# set the env to prod
#ENV MARTINI_ENV production

EXPOSE 22 3000
CMD []
ENTRYPOINT ["./gogs", "web"]
