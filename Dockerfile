FROM google/golang

# grab but do not build gogs
RUN go get -tags sqlite github.com/gogits/gogs

# set the working directory and add current stuff
WORKDIR /gopath/src/github.com/gogits/gogs
ADD . /gopath/src/github.com/gogits/gogs

# grab gopm to manage deps
#RUN go get github.com/gpmgo/gopm
# install deps and build bin (with sqlite support)
#RUN gopm install && go install -tags sqlite

CMD []
ENTRYPOINT ["/gopath/bin/gogs", "web"]
