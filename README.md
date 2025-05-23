![Challenge Picture](cover.png?raw=true "Challenge")

# DevOps Challenge



## Folder structure

/src
Contains the source code of the app. It's just 1 file.

/scripts
Development and testing scripts 

## Infrastructure

It's a self-managed Kubernetes cluster installed in a single VM (Master and Node)

The deployment runs in the "challenge" namespace

DIAGRAM HERE!!!!

### ArgoCD

ArgoCD services run in the "argocd" namespace

To access ArgoCD UI: [Link](https://challenge.hitechist.com:31522/)

GitHub SSO allows members of the "sejzer" organization

### ArgoCD RBAC roles and permissions

???????????

### Prometheus

Config
URL...
????????????

## The application

This is a web app "Hello World!" in go.
There new feature in version 2 is that it also prints the version.

### Public Image repository

[Docker Hub](https://hub.docker.com/r/techzer/helloworld)

Usage:
docker pull techzer/helloworld:2

### URLs

Because it's not a cloud service provider, it's missing the cloud controllers. I wasn't able to make API Gateway work.
I created new NodePort services that run in the only node
The NodePort services are located at /argocd/custom-services

To access the aplication:
[Link](http://challenge.hitechist.com:32003/)

### Testing the application

!!!!!!!!!!!

### Application Deployment

Application repository URL:
[Link](https://github.com/ssejzer/challenge)

just update the image in the master branch and ArgoCD will deploy it in the next minutes!



