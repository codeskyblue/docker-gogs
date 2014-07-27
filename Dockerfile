FROM google/golang

# grab but do not build gogs
RUN go get -d github.com/gogits/gogs

# set the working directory and add current stuff
WORKDIR /gopath/src/github.com/gogits/gogs
RUN git checkout v0.4.2
RUN go get -v
RUN go install -tags sqlite
ADD . /gopath/src/github.com/gogits/gogs

# set the env to prod
ENV MARTINI_ENV production

CMD []
ENTRYPOINT ["/gopath/bin/gogs", "web"]
