# Ingress-nginx with custom conf.d file injection

See [README.md](../../charts/ingress-nginx/README.md) for more information


```bash
cd ../ # cd helm-chart-boilerplate/examples/ingress-nginx-ssl-selfsigned
helm upgrade --install $RELEASE_NAME ../../charts/ingress-nginx --namespace default --values ./values-override.yaml
```
