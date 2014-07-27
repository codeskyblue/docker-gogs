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

# Use this app.ini file
ENV GOGS_CUSTOM ./app.ini

### config defaults, overriden via -e params at runtime
### base
ENV APP_NAME Gogs: Go Git Service
ENV APP_LOGO img/favicon.png
ENV RUN_USER git
ENV RUN_MODE dev

### repository
# ENV REPOSITORY_ROOT
ENV REPOSITORY_SCRIPT_TYPE bash

### server
ENV SERVER_PROTOCOL http
ENV SERVER_DOMAIN localhost
ENV SERVER_ROOT_URL %(PROTOCOL)s://%(DOMAIN)s:%(HTTP_PORT)s/
# ENV SERVER_HTTP_ADDR
ENV SERVER_HTTP_PORT 3000
ENV SERVER_SSH_PORT 22
ENV SERVER_OFFLINE_MODE false
ENV SERVER_DISABLE_ROUTER_LOG false
# Generate steps:
# cd path/to/gogs/custom/https
# go run $GOROOT/src/pkg/crypto/tls/generate_cert.go -ca=true -duration=8760h0m0s -host=myhost.example.com
ENV SERVER_CERT_FILE custom/https/cert.pem
ENV SERVER_KEY_FILE custom/https/key.pem
# Upper level of template and static file path
# default is the path where Gogs is executed
# ENV SERVER_STATIC_ROOT_PATH

# database
ENV DATABASE_DB_TYPE sqlite3
ENV DATABASE_HOST 127.0.0.1:3306
ENV DATABASE_NAME gogs
ENV DATABASE_USER root
# ENV DATABASE_PASSWD
# For "postgres" only, either "disable", "require" or "verify-full"
ENV DATABASE_SSL_MODE disable
# For "sqlite3" only
ENV DATABASE_PATH data/gogs.db

# admin

# security
ENV SECURITY_INSTALL_LOCK false
# Auto-login remember days
ENV SECURITY_LOGIN_REMEMBER_DAYS 7
ENV SECURITY_COOKIE_USERNAME gogs_awesome
ENV SECURITY_COOKIE_REMEMBER_NAME gogs_incredible
# Reverse proxy authentication header name of user name
ENV SECURITY_REVERSE_PROXY_AUTHENTICATION_USER X-WEBAUTH-USER

# service
ENV SERVICE_ACTIVE_CODE_LIVE_MINUTES 180
ENV SERVICE_RESET_PASSWD_CODE_LIVE_MINUTES 180
# User need to confirm e-mail for registration
ENV SERVICE_REGISTER_EMAIL_CONFIRM false
# Does not allow register and admin create account only
ENV SERVICE_DISABLE_REGISTRATION false
# User must sign in to view anything.
ENV SERVICE_REQUIRE_SIGNIN_VIEW false
# Cache avatar as picture
ENV SERVICE_ENABLE_CACHE_AVATAR false
# Mail notification
ENV SERVICE_ENABLE_NOTIFY_MAIL false
# More detail: https://github.com/gogits/gogs/issues/165
ENV SERVICE_ENABLE_REVERSE_PROXY_AUTHENTICATION false

# webhook
# Cron task interval in minutes
ENV WEBHOOK_TASK_INTERVAL 1
# Deliver timeout in seconds
ENV WEBHOOK_DELIVER_TIMEOUT 5

# mailer
ENV MAILER_ENABLED false
# Buffer length of channel, keep it as it is if you don't know what it is.
ENV MAILER_SEND_BUFFER_LEN 10
# Name displayed in mail title
ENV MAILER_SUBJECT %(APP_NAME)s
# Mail server
# Gmail: smtp.gmail.com:587
# QQ: smtp.qq.com:25
#ENV MAILER_HOST
# Mail from address
#ENV MAILER_FROM
# Mailer user name and password
#ENV MAILER_USER
#ENV MAILER_PASSWD

# oauth
ENV OAUTH_ENABLED

# oauth.github
ENV OAUTH_GITHUB_ENABLED false
#ENV OAUTH_GITHUB_CLIENT_ID
#ENV OAUTH_GITHUB_CLIENT_SECRET
#ENV OAUTH_GITHUB_SCOPES https://api_github_com/user
#ENV OAUTH_GITHUB_AUTH_URL https://github_com/login/oauth/authorize
#ENV OAUTH_GITHUB_TOKEN_URL https://github_com/login/oauth/access_token

# Get client id and secret from
# https://console.developers.google.com/project
# oauth.google
ENV OAUTH_GOOGLE_ENABLED false
#ENV OAUTH_GOOGLE_CLIENT_ID
#ENV OAUTH_GOOGLE_CLIENT_SECRET
#ENV OAUTH_GOOGLE_SCOPES https://www_googleapis_com/auth/userinfo_email https://www_googleapis_com/auth/userinfo_profile
#ENV OAUTH_GOOGLE_AUTH_URL https://accounts_google_com/o/oauth2/auth
#ENV OAUTH_GOOGLE_TOKEN_URL https://accounts_google_com/o/oauth2/token

# oauth.qq
ENV OAUTH_QQ_ENABLED false
#ENV OAUTH_QQ_CLIENT_ID
#ENV OAUTH_QQ_CLIENT_SECRET
#ENV OAUTH_QQ_SCOPES all
# QQ 互联
# AUTH_URL = https://graph.qq.com/oauth2.0/authorize
# TOKEN_URL = https://graph.qq.com/oauth2.0/token
# Tencent weibo
ENV OAUTH_QQ_AUTH_URL https://open_t_qq_com/cgi-bin/oauth2/authorize
ENV OAUTH_QQ_TOKEN_URL https://open_t_qq_com/cgi-bin/oauth2/access_token

# oauth.twitter
ENV OAUTH_TWITTER_ENABLED false
#ENV OAUTH_TWITTER_CLIENT_ID
#ENV OAUTH_TWITTER_CLIENT_SECRET
#ENV OAUTH_TWITTER_SCOPES all
#ENV OAUTH_TWITTER_AUTH_URL https://api_twitter_com/oauth/authorize
#ENV OAUTH_TWITTER_TOKEN_URL https://api_twitter_com/oauth/access_token

# oauth.weibo
ENV OAUTH_WEIBO_ENABLED false
#ENV OAUTH_WEIBO_CLIENT_ID
#ENV OAUTH_WEIBO_CLIENT_SECRET
#ENV OAUTH_WEIBO_SCOPES all
#ENV OAUTH_WEIBO_AUTH_URL https://api_weibo_com/oauth2/authorize
#ENV OAUTH_WEIBO_TOKEN_URL https://api_weibo_com/oauth2/access_token

# cache
# Either "memory", "redis", or "memcache", default is "memory"
ENV CACHE_ADAPTER memory
# For "memory" only, GC interval in seconds, default is 60
ENV CACHE_INTERVAL 60
# For "redis" and "memcache", connection host address
# redis: ":6039"
# memcache: "127.0.0.1:11211"
# ENV CACHE_HOST

# session
# Either "memory", "file", "redis" or "mysql", default is "memory"
ENV SESSION_PROVIDER file
# Provider config options
# memory: not have any config yet
# file: session file path, e.g. "data/sessions"
# redis: config like redis server addr, poolSize, password, e.g. "127.0.0.1:6379,100,astaxie"
# mysql: go-sql-driver/mysql dsn config string, e.g. "root:password@/session_table"
ENV SESSION_PROVIDER_CONFIG data/sessions
# Session cookie name
ENV SESSION_COOKIE_NAME surge_gogs
# If you use session in https only, default is false
ENV SESSION_COOKIE_SECURE false
# Enable set cookie, default is true
ENV SESSION_ENABLE_SET_COOKIE true
# Session GC time interval, default is 86400
ENV SESSION_GC_INTERVAL_TIME 86400
# Session life time, default is 86400
ENV SESSION_SESSION_LIFE_TIME 86400
# session id hash func, Either "sha1", "sha256" or "md5" default is sha1
ENV SESSION_SESSION_ID_HASHFUNC sha1
# Session hash key, default is use random string
#ENV SESSION_SESSION_ID_HASHKEY

# picture
# The place to picture data, either "server" or "qiniu", default is "server"
ENV PICTURE_SERVICE server
ENV PICTURE_DISABLE_GRAVATAR false

# log
ENV LOG_ROOT_PATH .
# Either "console", "file", "conn", "smtp" or "database", default is "console"
# Use comma to separate multiple modes, e.g. "console, file"
ENV LOG_MODE console
# Buffer length of channel, keep it as it is if you don't know what it is.
ENV LOG_BUFFER_LEN 10000
# Either "Trace", "Debug", "Info", "Warn", "Error", "Critical", default is "Trace"
ENV LOG_LEVEL Info

# For "console" mode only
### log.console
ENV LOG_CONSOLE_LEVEL Info

EXPOSE 22 3000
CMD []
ENTRYPOINT ["./start.sh"]
