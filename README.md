# challenge



## Folder structure

/src
Contains the source code of the app. It's just 1 file.

/scripts
Development and testing scripts 

## Infrastructure

The deployment runs in the "challenge" namespace

DIAGRAM HERE!!!!

### ArgoCD

ArgoCD services run in the "argocd" namespace

To access ArgoCD UI: https://challenge.hitechist.com:31522/

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

https://hub.docker.com/r/techzer/helloworld

Usage:
docker pull techzer/helloworld:2

### URLs

because it's not a cloud service provider,
I had to change the loadbalancers type to nodeport

To access the aplication:
http://challenge.hitechist.com:30174/

### Testing the application

!!!!!!!!!!!

### Application Deployment

Application repository URL:
https://github.com/ssejzer/challenge

just update the image in the master branch and ArgoCD will deploy it in the next minutes!



