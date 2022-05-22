# Ingress-nginx using 3306 HostPort for mysql TCP backend

See [README.md](../../charts/ingress-nginx/README.md)

1. Create a new `mysql.conf` file with TCP listener in [configmap-confd.yaml](../../charts/ingress-nginx/templates/configmap-confd.yaml)


2. Install the nginx ingress controller 


```bash
cd boilerplate/examples/ingress-nginx-tcp
helm upgrade --install ingress-nginx ../../charts/ingress-nginx --namespace default --values ./values-override.yaml
```


3. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](../../charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ../../charts/ingress-nginx/_sample-pod.yaml
```

4. Test connectivity 

See output from step 1