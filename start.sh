#!/bin/bash

cat template.ini | envsubst > app.ini

./gogs web
