# Generic Helm Chart

A generisied Helm chart for any use case following best-practises for security, scaling and zero-downtime updates.

Prerequisities: 

- helm >= 3

ToDo:

- Support for `DaemonSet` resource type

## Install

```bash
cd boilerplate # cd to the root 
helm upgrade --install myrelease ./charts/common --namespace app --create-namespace --values ./charts/common/example-values.yaml
```

Naming convention for pods is `{{ .Release.Namespace }}`-`{{ .Chart.Name }}`|`{{ .Values.nameOverride }`

- `.Release.Namespace` is the helm command line argument for namespace  `--namespace app`
- `.Chart.Name` is the name field in [Chart.yaml](./Chart.yaml)
- `.Values.nameOverride` is the value of nameOverride in the any values.yaml


## Documentation 

See comments in [values.yaml](./values.yaml)
See examples in [example-values.yaml](./charts/common/example-values.yaml) and [example-values2.yaml](./charts/common/example-values2.yaml)

## Uninstall

helm delete -n app myrelease

