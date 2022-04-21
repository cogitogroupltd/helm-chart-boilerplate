# Installing the helm chart 

Prerequisities: 

- Install tools
  - envsubst >= 0.2 # to allow for env var substituion in values.yaml
  - helm >= 3.3
  - aws >= 2.4
- An AWS user with permissions to ECR
- Docker image pushed to ECR for reference in `image.repository` in [values.yaml](./values.yaml)
- Create a secret in the same namespace as your application so it can be referenced in the `imagePullSecrets` defined in [values.yaml](./values.yaml)


  ```bash
  export AWS_ACCOUNT=
  export AWS_REGION=
  kubectl delete secret regcred --ignore-not-found && \
  kubectl create secret regcred \
    --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) \
    --namespace=app
  ```


## Install

export DB_PASSWORD="to_be_substituted_by_envsubst"
helm upgrade --install myrelease . --namespace app --create-namespace --values <(cat ./example-values.yaml | envsubst)


## Uninstall

helm delete -n app myrelease