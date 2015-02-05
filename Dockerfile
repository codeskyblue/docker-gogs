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

RUN useradd --shell /bin/bash --system --comment gogits git

RUN mkdir /var/run/sshd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed 's@UsePrivilegeSeparation yes@UsePrivilegeSeparation no@' -i /etc/ssh/sshd_config
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo "PermitUserEnvironment yes" >> /etc/ssh/sshd_config

# prepare data
ENV GOGS_CUSTOM /data/gogs
RUN echo "export GOGS_CUSTOM=/data/gogs" >> /etc/profile

RUN apt-get install -y rsync
ADD . /gopath/src/github.com/gogits/gogs

EXPOSE 22 3000
ENTRYPOINT []
CMD ["./start.sh"]
