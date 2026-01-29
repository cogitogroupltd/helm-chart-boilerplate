# Universal Helm Chart Boilerplate for Kubernetes

[![Helm Chart](https://img.shields.io/badge/Helm-Chart-0f1689?logo=helm)](https://cogitogroupltd.github.io/helm-chart-boilerplate)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Deployment-326CE5?logo=kubernetes)](https://kubernetes.io)
[![License](https://img.shields.io/github/license/cogitogroupltd/helm-chart-boilerplate)](LICENSE)

**Production-Ready Universal Kubernetes Helm Chart Template**

Deploy any application to Kubernetes with a single values file using this universal Helm chart boilerplate from [Cogito Group Ltd](https://cogitogroup.co.uk). Eliminate the need to write custom Helm charts for every microservice.

> Copyright [2024] [Cogito Group Ltd]

## Why Use This Helm Chart Boilerplate?

This **Universal Helm Chart Boilerplate** provides a comprehensive, reusable Helm chart template for deploying any application to Kubernetes:

- **One Chart, All Applications**: Deploy any microservice using a single Helm chart with different values files
- **Cloud Agnostic**: Works on EKS, AKS, GKE, OpenShift, K3s, MicroK8s, Kind, and bare metal
- **Production Ready**: Built-in support for ConfigMaps, Secrets, HPA, PersistentVolumes, and more
- **Developer Friendly**: Simple values.yaml configuration - no Helm chart expertise required
- **Enterprise Features**: Secrets management, autoscaling, health checks, and Helm hooks
- **Extensible**: RawYAML injection for custom Kubernetes resources

**Repository**: https://github.com/cogitogroupltd/helm-chart-boilerplate
**Helm Repository**: https://cogitogroupltd.github.io/helm-chart-boilerplate

## Quick Start - Deploy Applications with Helm Boilerplate

```bash
# Add the Helm Chart Boilerplate repository
helm repo add helm-boilerplate https://cogitogroupltd.github.io/helm-chart-boilerplate
helm repo update helm-boilerplate

# Deploy your application using the common chart
helm install my-app helm-boilerplate/app --values your-values.yaml
```

## Table of Contents

<!-- vscode-markdown-toc -->
* 1. [Key Features](#KeyFeatures)
* 2. [Platform Compatibility](#PlatformCompatibility)
* 3. [Helm Chart Boilerplate Features](#HelmChartBoilerplateFeatures)
* 4. [Installation Examples](#InstallationExamples)
	* 4.1. [Example - SSH Bastion Server Deployment](#Example-SSHBastionServerDeployment)
	* 4.2. [Example - Autoscaling Backend Service](#Example-AutoscalingBackendService)
	* 4.3. [Example - Complete Feature Demonstration](#Example-CompleteFeatureDemonstration)
	* 4.4. [Example - NodeJS Express Application](#Example-NodeJSExpressApplication)
	* 4.5. [Example - Orleans Kubernetes Application](#Example-OrleansKubernetesApplication)
	* 4.6. [Example - Static Nginx File Server](#Example-StaticNginxFileServer)
* 5. [Configuration](#Configuration)
* 6. [Contributing](#Contributing)
* 7. [Support](#Support)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='KeyFeatures'></a>Key Features of Universal Helm Chart Boilerplate

This Kubernetes Helm chart boilerplate provides everything needed for production deployments:

### Configuration Management
- **ConfigMap Environment Variables**: Inject configuration via `.Values.configenv`
- **ConfigMap Files**: Mount configuration files inline via `.Values.configMap.files`
- **Secret Environment Variables**: Secure credentials via `.Values.secenv`
- **Secret Files**: Mount sensitive files inline via `.Values.secret.files`
- **External Secrets**: Integration with external secret managers

### Kubernetes Resources
- **Deployments**: Standard Kubernetes deployment with full customization
- **Services**: Multiple service definitions via `.Values.services`
- **Ingress**: Kubernetes ingress resource configuration
- **PersistentVolumes**: Automatic PV/PVC creation via `.Values.persistence`
- **Jobs**: Kubernetes jobs and CronJobs support
- **RawYAML Injection**: Include any custom Kubernetes YAML

### Advanced Features
- **Horizontal Pod Autoscaler (HPA)**: Automatic scaling based on CPU/memory
- **InitContainers**: Pre-deployment initialization via `.Values.initContainers`
- **Sidecar Containers**: Redis sidecar support via `.Values.RedisSidecar`
- **Helm Hooks**: Pre/post install/upgrade hooks via `.Values.hook`
- **Health Checks**: Liveness and readiness probes
- **Resource Limits**: CPU and memory limits/requests

### Security Features
- **Service Accounts**: Kubernetes RBAC integration
- **Role-Based Access**: Orleans and other RBAC configurations
- **Secret Management**: Encrypted secret storage
- **Network Policies**: (via rawYAML injection)

See [values.yaml](./charts/common/values.yaml) for complete configuration options.

##  2. <a name='PlatformCompatibility'></a>Platform Compatibility - Tested Kubernetes Environments

This Universal Helm Chart Boilerplate has been successfully tested on:

- **AWS EKS**: Elastic Kubernetes Service
- **Azure AKS**: Azure Kubernetes Service
- **Google GKE**: Google Kubernetes Engine
- **OpenShift**: ROSA and OKD distributions
- **Rancher K3s**: Lightweight Kubernetes
- **MicroK8s**: Canonical's minimal Kubernetes
- **Kind**: Kubernetes in Docker for local development
- **Bare Metal**: On-premise Kubernetes clusters

##  3. <a name='HelmChartBoilerplateFeatures'></a>Helm Chart Boilerplate Features

This universal Helm chart boilerplate eliminates the need to write custom charts for each application. Instead, define everything in a `values.yaml` file:

```yaml
# Example values.yaml for deploying any application
replicaCount: 3

image:
  repository: myregistry/myapp
  tag: "1.0.0"
  pullPolicy: IfNotPresent

# Environment variables from ConfigMap
configenv:
  LOG_LEVEL: "info"
  API_URL: "https://api.example.com"

# Secret environment variables
secenv:
  DATABASE_PASSWORD: "mysecretpassword"
  API_KEY: "secretapikey"

# Service configuration
service:
  type: ClusterIP
  port: 80
  targetPort: 8080

# Horizontal Pod Autoscaler
hpa:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70

# Persistent storage
persistence:
  enabled: true
  size: 10Gi
  mountPath: /data
```

##  4. <a name='InstallationExamples'></a>Installation Examples - Helm Chart Boilerplate Deployments

###  4.1. <a name='Example-SSHBastionServerDeployment'></a>Example - SSH Bastion Server Deployment

Deploy an SSH bastion server for secure cluster access using the Helm chart boilerplate.

See [README.md](./charts/common/README.md) for more information.

```bash
cd helm-chart-boilerplate
helm upgrade --install sshd ./charts/common \
  --values ./examples/common-sshd/values-override.yaml
```

###  4.2. <a name='Example-AutoscalingBackendService'></a>Example - Autoscaling Backend Service

Deploy a backend microservice with horizontal pod autoscaling using the Helm boilerplate.

See [README.md](./charts/common/README.md) for more information.

```bash
cd helm-chart-boilerplate
helm upgrade --install myrelease ./charts/common \
  --values ./examples/common-backend-autoscaling/values-override.yaml
```

###  4.3. <a name='Example-CompleteFeatureDemonstration'></a>Example - Complete Feature Demonstration

This example demonstrates all features of the Helm chart boilerplate:

- InitContainer to sync AWS S3 bucket contents to container `/app/data`
- Helm webhook executed prior to starting runtime container
- ConfigMap and Secret management
- Persistent storage
- Multiple services

**Prerequisites**: Configure AWS credentials and ECR access

```bash
export AWS_ACCOUNT=123456789012
export AWS_REGION=us-east-1

kubectl delete secret regcred --ignore-not-found && \
kubectl create secret docker-registry regcred \
  --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password) \
  --namespace=app
```

**Deploy application**:

```bash
cd helm-chart-boilerplate
helm upgrade --install myrelease ./charts/common \
  --values ./examples/common-complete/values-override.yaml \
  --namespace app
```

**Advanced deployment with runtime variables**:

```bash
export AWS_SECRET_ACCESS_KEY=<your-secret-key>
export RABBIT_PASSWD=<rabbitmq-password>

helm upgrade --install myrelease ./charts/common \
  --values ./examples/common-complete/values-override.yaml \
  --namespace app \
  --set secenv.RABBIT_PASSWD=${RABBIT_PASSWD} \
  --set image.pullPolicy=Always \
  --set "initContainers[0].env[1].value=${AWS_SECRET_ACCESS_KEY}"
```

###  4.4. <a name='Example-NodeJSExpressApplication'></a>Example - NodeJS Express Application

Deploy a NodeJS Express server with rawYAML injection using the Helm boilerplate.

See [README.md](./charts/common/README.md) for more information.

```bash
cd helm-chart-boilerplate
export DB_PASSWORD=pass123

helm upgrade --install node-express ./charts/common \
  --values ./examples/common-node-express/values-override.yaml \
  --set secenv.DB_PASSWORD=${DB_PASSWORD}
```

###  4.5. <a name='Example-OrleansKubernetesApplication'></a>Example - Orleans Kubernetes Application

Deploy Microsoft Orleans applications with RBAC using the Helm chart boilerplate.

See [README.md](./charts/common/README.md) for more information.

```bash
cd helm-chart-boilerplate
export DB_PASSWORD=pass123

helm upgrade --install orleans-app ./charts/common \
  --values ./examples/common-orleans/values-override.yaml \
  --set secenv.DB_PASSWORD=${DB_PASSWORD}
```

###  4.6. <a name='Example-StaticNginxFileServer'></a>Example - Static Nginx File Server

Deploy Nginx with static file mounts using the Helm boilerplate.

```bash
cd helm-chart-boilerplate
helm upgrade --install common-nginx ./charts/common \
  --values ./examples/common-nginx-static/values-override.yaml
```

##  5. <a name='Configuration'></a>Configuration

### Helm Values Configuration

See [values.yaml](./charts/common/values.yaml) for all available configuration options.

### Key Configuration Sections

**Basic Deployment**:
```yaml
replicaCount: 3
image:
  repository: myregistry/myapp
  tag: "1.0.0"
```

**ConfigMap and Secrets**:
```yaml
configenv:
  MY_VAR: "value"
secenv:
  MY_SECRET: "secretvalue"
```

**Autoscaling**:
```yaml
hpa:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
```

**Storage**:
```yaml
persistence:
  enabled: true
  size: 10Gi
  mountPath: /data
```

##  6. <a name='Contributing'></a>Contributing & Support

### How to Contribute to Helm Chart Boilerplate

We welcome contributions! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Get Help

- **Issues**: [GitHub Issues](https://github.com/cogitogroupltd/helm-chart-boilerplate/issues)
- **Documentation**: [docs/](./docs/)
- **Examples**: [examples/](./examples/)
- **Blog**: [Cogito Group Blog](https://cogitogroup.co.uk/blog)

### Stay Updated

- **Star this repository** to receive updates about new features
- **Watch releases** for notifications about new versions
- Follow [Cogito Group](https://cogitogroup.co.uk) for Kubernetes and DevOps insights

##  7. <a name='Support'></a>Related Projects & Resources

- [Pure Ingress-Nginx Helm Chart](https://github.com/cogitogroupltd/pure-ingress-nginx) - Native Nginx ingress controller
- [Tekton Helm Chart](https://github.com/cogitogroupltd/tekton-helm-chart) - Tekton CI/CD pipelines
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Helm Documentation](https://helm.sh/docs/)

## License

This Universal Helm Chart Boilerplate is licensed under the terms specified in the LICENSE file.

Copyright [2024] [Cogito Group Ltd]

---

**Keywords**: Helm Chart, Kubernetes, Helm Boilerplate, Universal Helm Chart, Kubernetes Deployment, Cloud Native, DevOps, Microservices, ConfigMap, Secrets, HPA, Autoscaling, PersistentVolume, Kubernetes Template, Helm Template, Generic Helm Chart
