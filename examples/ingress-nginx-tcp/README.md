# Ingress-nginx using 3306 HostPort for mysql TCP backend

See [README.md](../../charts/ingress-nginx/README.md)

1. Create a new `mysql.conf` file with TCP listener in [configmap-confd.yaml](charts/ingress-nginx/templates/configmap-confd.yaml)


2. Install ingress-nginx 

```bash
cd boilerplate/examples/ingress-nginx
helm upgrade --install ingress-nginx ../../charts/ingress-nginx --namespace default --values ./values-override.yaml
```