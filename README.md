# Environment agnostic Kubernetes Helm charts

Free DevOps tools to help your business grow with minimal overheads. 


Contents: 

- `common` Kubernetes Generic Helm Chart - for all of your organisation's applications

- `ingress-nginx` Kubernetes Nginx ingress controller using pure Nginx for use with all your environments, local, on-premise and/or cloud


Successfully tested on:
 - AWS EKS using NLB and ALB
 - Kind [link](https://kind.sigs.k8s.io/)
 - Rancher K3s 
 - Google Kubernetes Engine (GKE)

## Ingress-nginx 

Features:
- Uses purley native Nginx configuration 
- Basic username/password authentication for each proxied application
- IP Whitelisting for each proxied application
- Zero-downtime rollingUpdate for any cluster with 2 or more nodes
- Cloud agnostic deployment exposing HostPort or NodePort



See HostPort [example](./examples/ingress-nginx-hostport/README.md)
See NodePort [example](./examples/ingress-nginx/README.md)


## Common


Example products our customers have built using our generic helm chart:

- SSH bastion host running on K8s
- ZeroTier connected K8s pods
- Orleans ready containers
- Nexus Docker registry
- Tekton environment agnostic pipelines
