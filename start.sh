#!/bin/bash

envsubst < template.ini > app.ini

./gogs web
