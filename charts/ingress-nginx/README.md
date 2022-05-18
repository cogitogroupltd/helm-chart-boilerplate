# Install the chart

See [NOTES.txt](./templates/NOTES.txt) for more information on the prereqs. 

## Production

Deploy the DaemonSet to a new namespace 

```bash
cd boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --values ./examples/ingress-nginx/values-override.yaml --create-namespace --namespace ingress-nginx --debug 
```

## Testing

When running in production it might be necessary to deploy another instance of ingress-nginx alongside the existing one for development and debugging. To do this without getting port conflicts use the test values file which uses a different set of NodePort services


```bash
helm upgrade --install ingress-nginx-dev charts/ingress-nginx --namespace ingress-nginx-dev --create-namespace --values charts/ingress-nginx/values-override-development.yaml --debug
```

- Once the testing instance(s) are running, port-forward to localhost. This will allow a HTTP connection to the ingresss on localhost:8888.

```bash
kubectl port-forward ds/ingress-nginx-dev --namespace ingress-nginx-dev 8888:80 &
```