# Environment agnostic ingress-nginx controller DaemonSet

## Parameters

See [values.yaml](./values.yaml) for examples 

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| basicAuth.enabled | bool | `false` |  |
| basicAuth.users.admin | string | `"SomePassWord."` |  |
| image.name | string | `"nginx"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `"1.17.9"` |  |
| livenessProbe | string | `nil` |  |
| readinessProbe | string | `nil` |  |
| rollingUpdateMaxUnavailable | int | `1` |  |
| services[0].containerPort | int | `80` |  |
| services[0].hostPort | int | `80` |  |
| services[0].name | string | `"http"` |  |
| services[1].containerPort | int | `443` |  |
| services[1].hostPort | int | `443` |  |
| services[1].name | string | `"https"` |  |
| ssl.enabled | bool | `false` |  |
| startupProbe | string | `nil` |  |
| whitelisting.addresses.example | string | `"1.2.3.4/32"` |  |
| whitelisting.enabled | bool | `false` |  |
----------------------------------------------


## Usage

See [NOTES.txt](./templates/NOTES.txt) for more information on the prerequisites. 


1. Deploy the ingress nginx controller

```bash
cd boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --values ./examples/ingress-nginx-tcp/values-override.yaml --create-namespace --namespace ingress-nginx --debug 
```

2. Test connectivity

Once the testing instance(s) are running, port-forward to localhost. This will allow a HTTP connection to the ingress on localhost:8888.

```bash
kubectl port-forward ds/ingress-nginx --namespace ingress-nginx 8888:80 &
```

## Uninstall

helm delete ingress-nginx -n ingress-nginx