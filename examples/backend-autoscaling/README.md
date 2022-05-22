# Helm Chart with secure secrets injection into environments variables

See [README.md](../../charts/common/README.md)

```bash
cd boilerplate/examples/backend-autoscaling
helm upgrade --install myrelease ../charts/common --values ./override-values.yaml
```