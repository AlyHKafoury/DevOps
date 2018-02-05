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

12. Made a second image of the application for **sidekiq** running a custom command in the `docker-compose.yml` file using the tag `command: bundle exec sidekiq -C config/sidekiq.yml`

### Steps to Run (Linux)

1. Install **Docker**
2. Install **Docker Compose**
3. From the terminal navigate to the `docker directory` inside the root of the repository `example: cd /$REPO_ROOT/docker`
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

7. Created **kubernetes secret object** with the secret **environment variables** and encoded them in **base64** in `rails-secrets.yml` and apply it using :
```sh
kubectl apply -f rails-secrets.yml
```

8. Created **kubernetes config map object** in `rails-configmap.yml` and appy it using :
```sh
kubectl apply -f rails-configmap.yml
```

9. Created **postgres** and **redis** containers with **clusterIP** services (only exposed to pods in the cluster) and configured them to have a **hostPath persistent storage** with the tag `type: DirectoryOrCreate` in the `hostPath:` tag so that it creats the directory inside the **minikube virtual machine** if it doesnt exist and apply those deployments files `pg-deployment.yml` , `redis-deployment.yml` using :
```sh
kubectl apply -f pg-deployment.yml
kubectl apply -f redis-deployment.yml
```

10. Created the **Job Object** to setup the database for first time run in `first-run-database-setup.yml` and apply it using:
```sh
kubectl apply -f first-run-database-setup.yml
```

11. Created the **application deployment** with the tag `imagePullPolicy: Never` so that it uses the locally built container in **step 6** and provided the secret environment variables with the tags `valueFrom:` and `secretKeyRef: rails-secrets` to use the **secret object** we created in **step 7**, also using the **configmap** object we **Overwrite** some default environment variables in the container using the tags `valueFrom:` and `configMapKeyRef:` giving it the name of our **configmap** in the tag `name: rails-configmap` and key value in tag `key:`. Created a **service object** for this deployment using the tag `type: NodePort` so that it becomes accessible from the **minikube** host machine , created this deployment in file `rails-deployment` and apply it using:
```sh
kubectl apply -f rails-deployment.yml
```

12. Created and Identical deployment to the **application deployment** for **sidekiq** this one doesnt need to be accessed so no service is created and running a custom command tag `command: ['bundle','exec','sidekiq','-C','config/sidekiq.yml']` applying the deployment using:
```sh
kubectl apply -f sidekiq-deployment.yml
```

### Steps to Run (Linux)

1. Install **kubectl**

2. Install **minikube** (Provides local kubernetes node)

3. Install **Oracle's Virtual Box**

4. From the terminal navigate to the `kubernetes directory` inside the root of the repository `example: cd /$REPO_ROOT/kubernetes`

5. Run the following command to start minikube
```sh
minikube start --vm-driver=virtualbox
```
6. Run the following command to make **docker** inside the **minikube virtual machine** available in the host terminal
```sh
eval $(minikube docker-env)
```

7. Run `./run_kubernetes.sh`


8. Run the following command to get the address from which you can access the app :
```sh
minikube service list | grep rails-app | cut -d "|" -f4
```
