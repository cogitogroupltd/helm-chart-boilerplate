# Project Overview

This project contains a collection of Helm charts and related configurations for deploying various applications and services on Kubernetes. The directory structure is organized to facilitate easy management and deployment of these resources.

## Directory Structure

### `charts/`

This directory contains Helm charts for different applications and services. It is further divided into subdirectories:

- `library-chart/`: A Helm library chart providing common templates and utilities.
- `sub-charts/`: Contains individual sub-charts for specific components or services.
  - `miacademy-main/`: Helm chart for the `miacademy-main` component.
  - `miacademy-main-maintenance/`: Helm chart for maintaining the `miacademy-main` component.
  - `miacademy-website/`: Helm chart for the `miacademy-website` component.
  - `miacademy-writemostly-maintenance/`: Helm chart for maintaining the `miacademy-writemostly` component.
  - `middlemail/`: Helm chart for the `middlemail` component.
  - `regulator/`: Helm chart for the `regulator` component.
  - `wp-careers-wordpress/`: Helm chart for the `wp-careers-wordpress` component.
  - `wp-miaprep-homeschool-curriculum-wordpress/`: Helm chart for the `wp-miaprep-homeschool-curriculum-wordpress` component.
  - `wp-miaprep-homeschool-curriculum-mariadb/`: Helm chart for the MariaDB database for the `wp-miaprep-homeschool-curriculum` component.
- `miaplaza-chart/`: The main Helm chart for the `miaplaza` application, aggregating multiple sub-charts and dependencies.

## Usage


To deploy all services using the `miaplaza-chart` directory, use the following command:

```bash
cd charts/miaplaza-chart
helm upgrade -i miacademy . --values values.yaml -n miaplaza --create-namespace --dependency-update
```

To pass values to the dependencies, you can specify them in the `values.yaml` file under the corresponding dependency key. For example:

```yaml
miacademy-main:
  image:
    registry: registry.dev.miaplaza.com
    repository: infrastructure/postgresql
    tag: "15-6-0-0"
  # ...other values...

miacademy-website:
  image:
    registry: registry.dev.miaplaza.com
    repository: infrastructure/nginx
    tag: "1.19.6"
  # ...other values...
```

To deploy a specific component or service, navigate to the corresponding Helm chart directory and use the `helm install` or `helm upgrade` command with the appropriate values file.

For example, to deploy the `miacademy-website` component:

```bash
cd charts/sub-charts/miacademy-website
helm upgrade --install miacademy-website . --values values.yaml
```