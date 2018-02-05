#!/bin/bash

#THIS FILE is provided in the repo for running the project and SHOULD NOT EXIST, it should be in the """""".gitignore""""""""
export PG_PASSWORD='drkiq'
export RAILS_SECRET_TOKEN='b737b1f457d7c43bf5e49201e61bae55440ba8894261baeaa354822fa50a17e9341e7745b772407059a8ca9c5bcda3ea0cbed6bdaec18cc253f393dfb55166c8'
export RAILS_DATABASE_URL='postgresql://drkiq:drkiq@postgres:5432/drkiq?encoding=utf8&pool=5&timeout=5000'
docker-compose run --user "$(id -u):$(id -g)" drkiq rails db:reset
if [ $? -eq 0 ]; then
    rm first_time_run.sh
fi
./run_with_secrets.sh
