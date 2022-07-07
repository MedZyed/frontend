# Docker
***
### Building the application
```
ng build
```

### Creating Dockerfile
```
FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY /dist/angular-tour-of-heroes /usr/share/nginx/html
```

### Build docker image (and tag)
```
docker build --tag=fsouayah/demo-frontend:latest .
docker build -f Dockerfile-dev --tag=fsouayah/demo-frontend:1.1.0-dev .
```

### Running docker image
Connect to app using http://localhost:8080
```
docker run -p 8080:80 fsouayah/demo-frontend:latest
```

### Push image to docker registry
```
docker push fsouayah/demo-frontend
```

# Kubernetes
***

### Create deployment for a pod running a container with provided docker image
```
kubectl create deployment frontend-node --image=fsouayah/demo-frontend:latest
```

### Expose the Pod to the public internet using the kubectl expose command
```
kubectl expose deployment frontend-node --type="NodePort" --port 80
```

### Get details about the service
```
kubectl describe services/frontend-node
```

### Create port-forward to access container
Because of a bug in minikube we need to create a port forward to be able to call the application.
In the example below, we are forwarding the container's port 8080 to the local port 8085.
In this case, we should call the URL http://localhost:4205/greeting
```
kubectl port-forward service/frontend-node 4205:80
```

# Connecting backend and frontend
***

### Create deployment with configuration file
After cleaning up the old deployment, run below commands (in the project's root path) :
```
kubectl apply -f ./scripts/frontend-deployment.yaml
```

### Create service with configuration file
```
kubectl apply -f ./scripts/frontend-service.yaml
```

### Backend Sanity Check
We will create a port forwarding to the frontend service to be able to call access the UI :
```
kubectl port-forward service/docker-k8s-demo-frontend-svc 4205:80
```