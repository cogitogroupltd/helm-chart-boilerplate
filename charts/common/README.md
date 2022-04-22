# Installing the helm chart 

Prerequisities: 

- Install tools
  - helm >= 3
- Docker image pushed to a registry referenced in `image.repository` in [values.yaml](./values.yaml)


## Install

cd boilerplate # cd to the root 
helm upgrade --install myrelease ./charts/common --namespace app --create-namespace --values charts/common/example-values.yaml

Naming convention for pods is `{{.Release.Namespace}}`-`{{.Chart.Name}`|`{{.Values.nameOverride}`


## Uninstall

helm delete -n app myrelease