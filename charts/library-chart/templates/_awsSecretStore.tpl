{{- define "library-chart.awsSecretStore" -}}
{{- range $name, $data := .Values.SecretManager }}
{{ $type := $data.type }}
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
metadata:
  name: {{ $name }}
spec:
  provider: aws
  secretObjects:
  - data:
{{- range $k8sSecretName, $awsSecretName := $data }}
{{- if ne $k8sSecretName "type" }}
    - key: {{ $k8sSecretName }}
      objectName: {{ $awsSecretName }}
{{- end }}
{{- end }}
    secretName: {{ $name }}
    type:  {{ $type }}
  parameters:
    objects: |
{{- range $k8sSecretName, $awsSecretName := $data }}
{{- if ne $k8sSecretName "type" }}
        - objectName: {{ $awsSecretName }}
          objectType: "secretsmanager"
{{- end }}
{{- end }}
---
{{- end }}
{{- end }}