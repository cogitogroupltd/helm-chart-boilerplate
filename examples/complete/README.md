# Helm Chart with PV and PVC linking and initContainer

See [README.md](../../charts/common/README.md) for more information

Features:

- Runs initContainer to sync contents of AWS_S3_BUCKET_NAME to runtime container `/app/data`
- Runs a Helm webhook prior to starting runtime container


```bash
export AWS_ACCOUNT=123
export AWS_REGION=
kubectl delete secret regcred --ignore-not-found && \
kubectl create secret regcred \
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password) \
  --namespace=app
```


- Example 1 install command 
```bash
helm upgrade --install myrelease ../charts/common --values ./override-values.yaml
```

- Example 2 install command 

```bash
 export AWS_SECRET_ACCESS_KEY # AWS credential for initContainer s3 copy job
 export RABBIT_PASSWD=
helm upgrade --install myrelease ../charts/common --values ./override-values.yaml --namespace app --set secenv.RABBIT_PASSWD=NadmapyefHybIdviGlyilguvminorcAu  --image.pullPolicy=Always --set "initContainers[0].env[1].value=${AWS_SECRET_ACCESS_KEY}"
```