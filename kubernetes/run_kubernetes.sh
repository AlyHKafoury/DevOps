#!/bin/bash

docker build -t rails-app ../docker/
kubectl apply -f rails-secrets.yml
kubectl apply -f rails-configmap.yml
kubectl apply -f pg-deployment.yml
kubectl apply -f redis-deployment.yml
kubectl apply -f first-run-database-setup.yml
kubectl apply -f rails-deployment.yml
kubectl apply -f sidekiq-deployment.yml
