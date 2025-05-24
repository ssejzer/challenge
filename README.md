![Challenge Picture](cover.png?raw=true "Challenge")

# DevOps Challenge

``diff
- This application is not ready for production and does not have security measures implemented
```


## Infrastructure

It's a self-managed Kubernetes cluster installed in a single VM (Master and Node)

The deployment runs in the "challenge" namespace

DIAGRAM HERE!!!!

## Folder structure

/src
Contains the source code of the app. It's just 1 file.

/scripts
Development and testing scripts 

### ArgoCD

ArgoCD services run in the "argocd" namespace

To access ArgoCD UI: [Link](https://challenge.hitechist.com:31522/)

GitHub SSO allows members of the "sejzer" organization

### ArgoCD RBAC roles and permissions

GitHub SSO is working but I didn't manage to set RBAC properly. I can login but I can't deploy with my github user.

### Prometheus

To access Prometheus: [Link](http://challenge.hitechist.com:32001/)

## The application

This is a web app "Hello World!" in go.
There new feature in version 2 is that it also prints the version.

### Public Image repository

[Docker Hub](https://hub.docker.com/r/techzer/helloworld)

Usage:
docker pull techzer/helloworld:2

### URLs

To access the aplication:
[Link](http://challenge.hitechist.com:32003/)

### Testing the application

!!!!!!!!!!!

### Application Deployment

Application repository URL:
[Link](https://github.com/ssejzer/challenge)

just update the image in the master branch and ArgoCD will deploy it in the next minutes!

## Issues I had during the setup

I didn't understand why there is a hockey stick

I loved argoCD. I didn't know about it and the idea of pulling the changes instead of the usual way is fantastic.
And it's very smart. It knows when I move a manifest from one app to another.

I had a hard time finding why the Envoy didn't work until I realized it's because there is no Load Balancer Controller in self-managed clusters.
In the past, I worked with Azure Kubernetes for production and minikube for dev. Lesson learned!
The solution was to create NodePort services.
The NodePort services are located at /argocd/custom-services

The Prometheus POD didn't start because there wasn't available resources but there was plenty of CPU and RAM.
I found that for the self-mananged cluster I have to enable a storage class in order to the PVC get the requested storage.
The error was: "no persistent volumes available for this claim and no storage class is set"
The solution was to create a 100GB PersistentVolume (named "local-pv" ) pointing to a host path.

