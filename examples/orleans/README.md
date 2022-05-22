# Helm Chart for Orleans Kubernetes application

See [README.md](../../charts/common/README.md) for more information

```bash
cd boilerplate/examples/orleans
export DB_PASSWORD=pass123
helm upgrade --install node-express ../../charts/common --values ./override-values.yaml --set secenv.DB_PASSWORD=${DB_PASSWORD}
```