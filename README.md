![Challenge Picture](images/cover.png?raw=true "Challenge")

# DevOps Challenge

```diff
- This application is not ready for production and does not have security measures implemented
```


## Infrastructure

It's a self-managed Kubernetes cluster installed in a single VM (Control Plane and a single Node)

The [HelloWorld go application](src) is containeraized in a minimal image based on [Alpine Linux](https://hub.docker.com/_/alpine).


ArgoCD continuously monitors the GitHub Repo and applies the changes directly with the Kubernetes API
![Infrastructure Picture](images/infrastructure.png?raw=true "Infrastructure")

### Namespaces

- argoCD runs in the "argocd" namespace.
- The HelloWorld application and the Envoy Proxy are deployed to the "challenge" namespace.
- And Prometheus in the "monitoring" namespace.

## Folder structure

```bash
├── argocd. The infrastructure manifests.
│   ├── custom-services. Additional resources to make it work in a non-cloud provided cluster
├── helm-charts. Application continuos monitored Helm charts
├── images. Images for this documentation
├── scripts. Development and testing scripts
└── src. Contains the go source code of the app and the Dockerfile
```


### ArgoCD

To access ArgoCD UI: [Link](https://challenge.hitechist.com:31522/)

#### ArgoCD SSO authentication and permissions

ArgoCD is the Service Provider (SP) and GitHub Auth is the Identity Provider (IDP).
Only members of the [sejzer organization](https://github.com/sejzer) are allowed.
There are 2 roles defined in [argocd-rbac-cm.yaml](argocd/argocd-rbac-cm.yaml)
- Admin. Can do everything, everywhere.
- Developer. Can perform any action on the applications

### Prometheus

Prometheus collects metrics from the resources with `prometheus.io/scrape` set to `true`.

```yaml
annotations:
prometheus.io/scrape: 'true'
```

To access Prometheus UI, execute
```bash
kubectl -n monitoring port-forward service/prometheus-server 8080:80
```

And open the forwarded [Prometheus UI](http://localhost:8080/) in your browser.


## The application

This is a web app "Hello World!" in go.
There new feature in version 2 is that it also prints the version.

### Public Image repository

[Docker Hub](https://hub.docker.com/r/techzer/helloworld)

Usage:
```bash
docker pull techzer/helloworld:2
```

### Application publicly accessible URL

To access the aplication:
[Link](http://challenge.hitechist.com:32003/)


### Testing the application

To monitor the application, there's a [test script](scripts/test.sh) that can be included in CD or any monitoring tool.


### Application Deployment

The source code is in the [src](src) directory.
To update the application you have to manually build the docker image and push it to [Docker Hub](https://hub.docker.com/r/techzer/helloworld) with a new tag.
Then you just update the image version tag in the [helloworld.image.tag values.yaml file](https://github.com/ssejzer/challenge/blob/master/helm-charts/values.yaml#L4) at the master branch and ArgoCD will deploy it in the next minutes!

#### Horizontal Pod Autoscaling

The application deploys more PODs based on CPU usage.

## Issues I had during the setup and known bugs

I still didn't understand why there is a hockey stick. 🙂

I loved argoCD. I didn't know about it and the idea of pulling the changes instead of the usual way is fantastic.
And it's also smart. It knows when I move a manifest from one app to another.

The GitHub OAuth secret is not secured. It needs an external vault provider and removed from the repo.

I had a hard time finding why the Envoy Gateway didn't work until I realized it's because there is no Load Balancer Controller in self-managed clusters.
In the past, I worked with Azure Kubernetes for production and minikube for dev. Lesson learned!
The solution was to create NodePort services.
The NodePort services are located at `/argocd/custom-services`

There's also a [metrics-server](https://github.com/kubernetes-sigs/metrics-server) at `/argocd/custom-services` that was required by the HPA.

The HPA is implemented but not working properly because it's not getting the required metrics.

```bash
NAME                                                 REFERENCE               TARGETS              MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/helloworld-hpa   Deployment/helloworld   cpu: <unknown>/50%   2         10        1          106m
```

Even though the metrics server is working.

```bash
NAME                           CPU(cores)   MEMORY(bytes)
envoy-proxy-84c59894d7-jrpp4   4m           14Mi
helloworld-59c9675bd4-zgvzb    1m           3Mi
```

The Prometheus POD didn't start because there wasn't available resources but there was plenty of CPU and RAM.
I found that for the self-mananged cluster I have to enable a storage class in order to the PVC get the requested storage.
The error was: "no persistent volumes available for this claim and no storage class is set"
The solution was to create a couple of 64GB PersistentVolumes (named "local-pv" and "local-pv2" ) pointing to a host path.


