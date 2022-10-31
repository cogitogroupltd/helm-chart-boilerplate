# Cloud agnostic Kubernetes Helm charts

[Cogito Group's](https://cogitogroup.co.uk) cloud agnostic and generic Helm charts to help businesses securely scale with minimal DevOps overheads. 

Source repository https://github.com/cogitogroupltd/helm-chart-boilerplate

- [ingress-nginx](./charts/ingress-nginx/README.md) Kubernetes Nginx ingress controller using pure Nginx for deploying to all environments, local, on-premise and/or cloud
- [common](./charts/common/README.md) Kubernetes Generic Helm Chart for deploying all applications with a single parameter file using a single Helm chart


Table of contents:

<!-- vscode-markdown-toc -->
* 1. [Ingress-nginx](#Ingress-nginx)
	* 1.1. [Example - Ingress-nginx with custom conf.d file injection](#Example-Ingress-nginxwithcustomconf.dfileinjection)
	* 1.2. [Example - Ingress-nginx using 80/443 HostPorts](#Example-Ingress-nginxusing80443HostPorts)
	* 1.3. [Example - Ingress-nginx using NodePorts with self-signed SSL certificate termination](#Example-Ingress-nginxusingNodePortswithself-signedSSLcertificatetermination)
	* 1.4. [Example - Ingress-nginx using 3306 HostPort for mysql TCP backend](#Example-Ingress-nginxusing3306HostPortformysqlTCPbackend)
	* 1.5. [Example - Ingress-nginx AWS NLB with NodePorts and IP whitelisting](#Example-Ingress-nginxAWSNLBwithNodePortsandIPwhitelisting)
* 2. [Common](#Common)
	* 2.1. [Example - Helm Chart for SSH bastion server](#Example-HelmChartforSSHbastionserver)
	* 2.2. [Example - Autoscaling backend service](#Example-Autoscalingbackendservice)
	* 2.3. [Example - Complete deployment of full common features](#Example-Completedeploymentoffullcommonfeatures)
	* 2.4. [Example - Simple NodeJS express server with rawYaml injection](#Example-SimpleNodeJSexpressserverwithrawYamlinjection)
	* 2.5. [Example - Helm Chart for Orleans Kubernetes application](#Example-HelmChartforOrleansKubernetesapplication)
	* 2.6. [Example - Simple Nginx with static file mounts](#Example-SimpleNginxwithstaticfilemounts)
	* 2.7. [Example - Tekton helm chart](#Example-Tektonhelmchart)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


##  1. <a name='Ingress-nginx'></a>Ingress-nginx 

Features:
- Uses pure native Nginx configuration 
- WebSocket, SSL and TCP streaming backend support
- Healthcheck endpoint for Kubernetes lifecycle management
- Custom [40x.html](./charts/ingress-nginx/templates/configmap-conf.yaml) and [50x](./charts/ingress-nginx/templates/configmap-conf.yaml) error pages 
- Basic username/password authentication for each proxied application
- IP Whitelisting for each proxied application
- Zero-downtime upgrades using preStop hook `SIGQUIT` signal
- Cloud agnostic deployment exposing `HostPort` or `NodePort`

See [values.yaml](./charts/ingress-nginx/values.yaml) for full list of features

See `raw-yaml-output` directories for example outputted Kubernetes YAML 

Successfully tested on:
 - AWS EKS using NLB and ALB
 - Kind [download](https://kind.sigs.k8s.io/)
 - Rancher K3s 
 - Google Kubernetes Engine (GKE)


###  1.1. <a name='Example-Ingress-nginxwithcustomconf.dfileinjection'></a>Example - Ingress-nginx with custom conf.d file injection

See [example-raw-output.yaml](./examples/ingress-nginx-confd/example-raw-output.yaml) for example files outputted by helm templating.

```bash
cd helm-chart-boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --namespace default --values ./examples/ingress-nginx-confd/values-override.yaml
```

###  1.2. <a name='Example-Ingress-nginxusing80443HostPorts'></a>Example - Ingress-nginx using 80/443 HostPorts


1. Install the nginx ingress controller 

```bash
cd helm-chart-boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --namespace default --values ./examples/ingress-nginx-hostport/values-override.yaml
```

2. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](../../charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ./charts/ingress-nginx/_sample-pod.yaml
```

3. Test connectivity 

See output from step 1


###  1.3. <a name='Example-Ingress-nginxusingNodePortswithself-signedSSLcertificatetermination'></a>Example - Ingress-nginx using NodePorts with self-signed SSL certificate termination

See [example-raw-output.yaml](./examples/ingress-nginx-ssl-selfsigned/example-raw-output.yaml) for example files outputted by helm templating.

1. Create Kind cluster

```bash
cd helm-chart-boilerplate
kind create cluster --name kind --config ./examples/ingress-nginx-ssl-selfsigned/cluster.yaml
```

2. Create self-signed certificate files

```bash

cd helm-chart-boilerplate/examples/ingress-nginx-ssl-selfsigned
mkdir -p certs
cd certs
openssl req -x509 -sha256 -newkey rsa:4096 -keyout ca.key -out ca.crt -days 356 -nodes -subj '/CN=Self-Signed Cert Authority' 
openssl req -new -newkey rsa:4096 -keyout sample.key -out sample.csr -subj '/CN=sample.test.io'
#Remember this password for step 2

#Generate the Client Key, and Certificate and Sign with the CA Certificate
openssl x509 -req -sha256 -days 730 -in sample.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out sample.crt 
```

3. Store the encryption password in the configMap

Edit the content of `ssh_password_file` in [configmap-conf.yaml](./charts/ingress-nginx/templates/configmap-conf.yaml). "hello" is used as an example default.


4. Create K8s secrets with certificates and key

```bash
cd helm-chart-boilerplate
kubectl delete secret --ignore-not-found=true "ingress-nginx-certs" -n default ; kubectl create secret generic "ingress-nginx-certs" -n default --from-file=tls.key=./examples/ingress-nginx-ssl-selfsigned/sample.key --from-file=tls.crt=./examples/ingress-nginx-ssl-selfsigned/sample.crt ; 
```

5. Install the nginx ingress controller 

```bash
cd helm-chart-boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --namespace default --values ./examples/ingress-nginx-ssl-selfsigned/values-override.yaml
```

6. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](./charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ./charts/ingress-nginx/_sample-pod.yaml
```

7. Test connectivity 

See output from step 3


###  1.4. <a name='Example-Ingress-nginxusing3306HostPortformysqlTCPbackend'></a>Example - Ingress-nginx using 3306 HostPort for mysql TCP backend

See [example-raw-output.yaml](./examples/ingress-nginx-tcp/example-raw-output.yaml) for example files outputted by helm templating.

1. Create a new `mysql.conf` file with TCP listener in [configmap-confd.yaml](./charts/ingress-nginx/templates/configmap-confd.yaml)


2. Install the nginx ingress controller 


```bash
cd helm-chart-boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --namespace default --values ./examples/ingress-nginx-tcp/values-override.yaml
```


3. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](./charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ../../charts/ingress-nginx/_sample-pod.yaml
```

4. Test connectivity 

See output from step 2

###  1.5. <a name='Example-Ingress-nginxAWSNLBwithNodePortsandIPwhitelisting'></a>Example - Ingress-nginx AWS NLB with NodePorts and IP whitelisting

See [example-raw-output.yaml](./examples/ingress-nginx-whitelisting/example-raw-output.yaml) for example files outputted by helm templating.

1) Enable `PROXY_PROTOCOL` on the AWS NLB so we can use IP whitelisting for Jenkins

- First retreive the ARN of the HTTPS target group using the AWS console

- Configure NLB to use `proxy_protocol` with a `TargetGroup` attribute

For example:

`aws elbv2 modify-target-group-attributes --attributes Key=proxy_protocol_v2.enabled,Value=true --target-group-arn arn:aws:elasticloadbalancing:us-east-1:304793330600:targetgroup/eks-cluster-nlb-https-tg-80db4d8/0f41d883eebbc37e`

2. Install ingress-nginx 

```bash
cd helm-chart-boilerplate
helm upgrade --install ingress-nginx ./charts/ingress-nginx --namespace default --values ./examples/ingress-nginx-whitelisting/values-override.yaml
```

3. Install Sample application hosted on https://sample.test.io

NOTE: Namespace field must match up to value of `$backend` in [configmap-confd.yaml](./charts/ingress-nginx/templates/configmap-confd.yaml) 

```bash
kubectl apply -f ../../charts/ingress-nginx/_sample-pod.yaml
```

4. Test connectivity 

See output from step 2



##  2. <a name='Common'></a>Common

A generic helm chart to deploy a multitude of applications to Kubernetes using just a single input file `override-values.yaml`.

Features:
- Secrets mounted environment variables `.Values.secenv`
- Secrets mounted in-line `.Values.secret.files`
- ConfigMap mounted environment variables `.Values.configenv`
- ConfigMap mounted in-line `.Values.configMap.files`
- Services specified in-line `.Values.services`
- Redis side car container `.Values.RedisSidecar`
- InitContainers `.Values.initContainers`
- Helm Hooks `.Values.hook`
- PersistentVolume and PersistentVolumeClaim creation in-line `.Values.persistence`

See [values.yaml](./charts/common/values.yaml) for full list of features

###  2.1. <a name='Example-HelmChartforSSHbastionserver'></a>Example - Helm Chart for SSH bastion server 

See [README.md](./charts/common/README.md) for more information

```bash
cd helm-chart-boilerplate
helm upgrade --install sshd ./charts/common --values ./examples/common-sshd-bastion/override-values.yaml
```



###  2.2. <a name='Example-Autoscalingbackendservice'></a>Example - Autoscaling backend service

See [README.md](./charts/common/README.md) for more information

```bash
cd helm-chart-boilerplate
helm upgrade --install myrelease ./charts/common --values ./examples/common-backend-autoscaling/override-values.yaml
```

###  2.3. <a name='Example-Completedeploymentoffullcommonfeatures'></a>Example - Complete deployment of full common features

See [README.md](./charts/common/README.md) for more information

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
cd helm-chart-boilerplate
helm upgrade --install myrelease ./charts/common --values ./examples/common-complete/override-values.yaml
```

- Example 2 install command 

```bash
 export AWS_SECRET_ACCESS_KEY # AWS credential for initContainer s3 copy job
 export RABBIT_PASSWD=
helm upgrade --install myrelease ./charts/common --values ./override-values.yaml --namespace app --set secenv.RABBIT_PASSWD=NadmapyefHybIdviGlyilguvminorcAu  --image.pullPolicy=Always --set "initContainers[0].env[1].value=${AWS_SECRET_ACCESS_KEY}"
```

###  2.4. <a name='Example-SimpleNodeJSexpressserverwithrawYamlinjection'></a>Example - Simple NodeJS express server with rawYaml injection

See [README.md](./charts/common/README.md) for more information

```bash
cd helm-chart-boilerplate
export DB_PASSWORD=pass123
helm upgrade --install node-express ./charts/common --values ./examples/common-node-express/override-values.yaml --set secenv.DB_PASSWORD=${DB_PASSWORD}
```

###  2.5. <a name='Example-HelmChartforOrleansKubernetesapplication'></a>Example - Helm Chart for Orleans Kubernetes application

See [README.md](./charts/common/README.md) for more information

```bash
cd helm-chart-boilerplate
export DB_PASSWORD=pass123
helm upgrade --install node-express ./charts/common --values ./examples/common-orleans//override-values.yaml --set secenv.DB_PASSWORD=${DB_PASSWORD}
```

###  2.6. <a name='Example-SimpleNginxwithstaticfilemounts'></a>Example - Simple Nginx with static file mounts


```bash
cd helm-chart-boilerplate
helm upgrade --install common-nginx ./charts/common --values ./examples/common-nginx-static/values-override.yaml
```

###  2.7. <a name='Example-Tektonhelmchart'></a>Example - Tekton helm chart

TBC
