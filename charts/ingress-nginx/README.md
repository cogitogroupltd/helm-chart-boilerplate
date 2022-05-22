# Install the chart

See [NOTES.txt](./templates/NOTES.txt) for more information on the prerequisites. 


1. Deploy the ingress nginx controller

```bash
cd boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --values ./examples/ingress-nginx-tcp/values-override.yaml --create-namespace --namespace ingress-nginx --debug 
```

2. Test connectivity

Once the testing instance(s) are running, port-forward to localhost. This will allow a HTTP connection to the ingress on localhost:8888.

```bash
kubectl port-forward ds/ingress-nginx --namespace ingress-nginx-dev 8888:80 &
```