# DevOps

## __**Docker**__
===========

### Steps to create

1. Install **Docker**

2. Install **Docker Compose**

3. Created the application using the docker container method from the tutorial however upgraded to **rails 5** which is the latest
```sh
# OSX/Windows users will want to remove --­­user "$(id -­u):$(id -­g)"
docker run -it --rm --user "$(id -u):$(id -g)" \
  -v "$PWD":/usr/src/app -w /usr/src/app rails:5 rails new --skip-bundle drkiq
```

4. Configured rails `database.yml` and `secrets.yml` to use **environment variables**

5. Created **Unicorn** configuration files and configured it to use **environment variables**

6. Add the **environment variables** to the `Dockerfile` instead of using `.env` file

7. Changed the `Dockerfile` supplied with the tutorial to add `CMD bundle exec rails db:migrate` to ensure latest version of the database when running the image

8. Created the `docker-compose.yml` file and supplied some **environment variables** to the `environment:` tag to **Overwrite** some of the defaults existing inside the `Dockerfile`

9. Supplied the **secrets environment variables** as **environment variables** in the **Host machine**

10. In each **container** gave each an exposed port which maps to a local port having the required service

11. Configured **persistent volumes storage** for each container

### Steps to Run (Linux)

1. Install **Docker**
2. Install **Docker Compose**
3. From the terminal navigate to the `docker folder` inside the root of the repository `example: cd /$REPO_ROOT/docker`
4. Run `./first_time_run.sh`
>This file will remove iteself after first successful run
5. Run next time using `./run_with_secrets.sh`
6. **Both first_time_run.sh and run_with_secrets.sh shouldn't exist in a repo as they contain secrets**


## __**Kubernetes**__
==================

### Steps to create

1. Install **kubectl**

2. Install **minikube** (Provides local kubernetes node)

3. Install **Oracle's Virtual Box**

4. Run the following command to start minikube
```sh
minikube start --vm-driver=virtualbox
```
5. Run the following command to make **docker** inside the **minikube virtual machine** available in the host terminal
```sh
eval $(minikube docker-env)
```

6. Run the following command to build the application container locally for the **minikube virtual machine**
```sh
docker build -t rails-app ../docker/
```

7. Created **kubernetes secret object** in `rails-secrets.yml` and apply it using :
```sh
kubectl apply -f rails-secrets.yml
```

8. Created **kubernetes config map object** in `rails-configmap.yml` and appy it using :
```sh
kubectl apply -f rails-configmap.yml
```

9. 
