# Ingress-nginx using 80/443 HostPorts and IP whitelisting

See [README.md](../../charts/ingress-nginx/README.md)


1. Install the nginx ingress controller 

```bash
cd boilerplate/examples/ingress-nginx-whitelisting
helm upgrade --install ingress-nginx ../../charts/ingress-nginx-whitelisting --namespace default --values ./values-override.yaml
```

2. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ../../charts/ingress-nginx/_sample-pod.yaml
```

3. Test connectivity 

See output from step 1