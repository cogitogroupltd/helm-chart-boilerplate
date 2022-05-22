# Ingress-nginx AWS NLB with NodePorts and IP whitelisting

See [README.md](../../charts/ingress-nginx/README.md) for more information


1) Enable `PROXY_PROTOCOL` on the AWS NLB so we can use IP whitelisting for Jenkins

- First retreive the ARN of the HTTPS target group using the AWS console

- Configure NLB to use `proxy_protocol` with a `TargetGroup` attribute

For example:

`aws elbv2 modify-target-group-attributes --attributes Key=proxy_protocol_v2.enabled,Value=true --target-group-arn arn:aws:elasticloadbalancing:us-east-1:304793330600:targetgroup/eks-cluster-nlb-https-tg-80db4d8/0f41d883eebbc37e`

2. Install ingress-nginx 

```bash
cd boilerplate/examples/ingress-nginx
helm upgrade --install ingress-nginx ../../charts/ingress-nginx --namespace default --values ./values-override.yaml
```

