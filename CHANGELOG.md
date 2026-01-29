# Changelog

All notable changes to the Universal Helm Chart Boilerplate will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Enhanced SEO optimization for better discoverability
- Improved Chart.yaml metadata with comprehensive keywords
- Separated ingress-nginx into dedicated repository
- Updated README.md with keyword-rich content focused on common chart
- Renamed repository focus to "Universal Helm Chart Boilerplate"

## [0.5.2] - 2024-01-29

### Changed
- Split ingress-nginx functionality into separate repository
- Focus exclusively on universal/common Helm chart boilerplate
- Enhanced documentation and examples

## [0.5.1] - 2024-06-10

### Features
- **Universal Helm Chart**: Deploy any application with a single values file
- **ConfigMap Support**: Environment variables and file injection
- **Secret Management**: Secure credential storage and mounting
- **Horizontal Pod Autoscaler**: Automatic scaling based on metrics
- **PersistentVolumes**: Automated PV/PVC creation
- **InitContainers**: Pre-deployment initialization support
- **Sidecar Containers**: Redis sidecar and other sidecar patterns
- **Helm Hooks**: Pre/post install/upgrade hooks
- **Jobs and CronJobs**: Scheduled task support
- **RawYAML Injection**: Custom Kubernetes resource inclusion
- **Orleans Support**: Microsoft Orleans RBAC configuration

### Platform Support
- AWS EKS
- Azure AKS
- Google Kubernetes Engine (GKE)
- OpenShift (ROSA and OKD)
- Rancher K3s
- MicroK8s
- Kind (local development)
- Bare Metal Kubernetes

### Examples
- SSH bastion server deployment
- Autoscaling backend service
- Complete feature demonstration with S3 sync
- NodeJS Express application
- Orleans Kubernetes application
- Static Nginx file server

## [0.5.0] - Initial Release

### Added
- Initial Universal Helm Chart Boilerplate
- Basic ConfigMap and Secret templates
- Deployment and Service templates
- HPA template
- PersistentVolume templates

---

For more details, see the [GitHub repository](https://github.com/cogitogroupltd/helm-chart-boilerplate) or raise an [issue](https://github.com/cogitogroupltd/helm-chart-boilerplate/issues).
