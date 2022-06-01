# Generic Helm Chart

A generisied Helm chart for any use case following best-practises for security, scaling and zero-downtime updates.

Prerequisities: 

- helm >= 3

ToDo:

- Support for `DaemonSet` resource type

## Usage

```bash
cd helm-chart-boilerplate # cd to the root 
helm upgrade --install myrelease ./charts/common --namespace app --create-namespace 
```

## Parameters

See [values.yaml](./values.yaml) for examples 

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `1` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| configMap.enabled | bool | `false` |  |
| configMap.envFrom | bool | `false` |  |
| deploymentLabels | object | `{}` |  |
| env | list | `[]` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| hook.enabled | bool | `false` |  |
| hook.image.pullPolicy | string | `"Always"` |  |
| hook.image.repository | string | `"mcr.microsoft.com/mssql-tools"` |  |
| hook.image.tag | string | `"1.0.0"` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `""` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets[0].name | string | `"regcred"` |  |
| initContainers.args | list | `[]` |  |
| initContainers.command | list | `[]` |  |
| initContainers.enabled | bool | `false` |  |
| initContainers.extraVolumeMounts | list | `[]` |  |
| initContainers.extraVolumes | list | `[]` |  |
| initContainers.image.imagePullPolicy | string | `nil` |  |
| initContainers.image.repository | string | `nil` |  |
| initContainers.image.tag | string | `nil` |  |
| livenessProbe | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector."beta.kubernetes.io/arch" | string | `"amd64"` |  |
| nodeSelector."beta.kubernetes.io/os" | string | `"linux"` |  |
| orleans.enabled | bool | `false` |  |
| persistence.accessMode | string | `"ReadWriteMany"` |  |
| persistence.enabled | bool | `false` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClassName | string | `"default"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| rawYaml.content | string | `"kind: RoleBinding\napiVersion: rbac.authorization.k8s.io/v1\nmetadata:\n  name: myrelease-app-pod-reader-binding1\n  namespace: default\nsubjects:\n- kind: ServiceAccount\n  name: myrelease-app\n  apiGroup: ''\nroleRef:\n  kind: Role\n  name: myrelease-app-pod-reader\n  apiGroup: ''\n"` |  |
| rawYaml.enabled | bool | `false` |  |
| readinessProbe | object | `{}` |  |
| redisSidecar.enabled | bool | `false` |  |
| redisSidecar.image | string | `"redis"` |  |
| redisSidecar.livenessInterval | int | `30` |  |
| redisSidecar.pullPolicy | string | `"Always"` |  |
| redisSidecar.targetPort | int | `6379` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.enabled | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| services[0].containerPort | int | `80` |  |
| services[0].name | string | `"http"` |  |
| services[0].targetPort | int | `80` |  |
| services[0].type | string | `"ClusterIP"` |  |
| startupProbe | object | `{}` |  |
| tolerations | list | `[]` |  |

----------------------------------------------



## Documentation 

See comments in [values.yaml](./values.yaml)
See examples in [example-values.yaml](./charts/common/example-values.yaml) and [example-values2.yaml](./charts/common/example-values2.yaml)

## Uninstall

```bash
helm delete -n app myrelease
```