# Collection of Helm charts and examples 

## Ingress-nginx controller - cloud agnostic

Successfully tested on:
 - AWS EKS using NLB
 - AWS EKS using ALB
 - Kind [link](https://kind.sigs.k8s.io/)
 - Rancher K3s 
 - Google Kubernetes Engine (GKE)

Features:
- Uses purley native Nginx configuration 
- Basic username/password authentication for each proxied application
- IP Whitelisting for each proxied application
- Zero-downtime rollingUpdate for any cluster with 2 or more nodes
- Cloud agnostic deployment exposing HostPort or NodePort



See [examples](./examples)