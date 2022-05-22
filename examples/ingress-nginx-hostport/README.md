# Ingress-nginx using 80/443 HostPorts and IP whitelisting

See [README.md](../../charts/ingress-nginx/README.md)

```bash
cd boilerplate/examples/ingress-nginx-whitelisting
helm upgrade --install ingress-nginx ../../charts/ingress-nginx-whitelisting --namespace default --values ./values-override.yaml
```