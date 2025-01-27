{{- define "library-chart.external-secret.tpl" -}}
{{- range .Values.externalSecrets.secrets }}
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: {{ .name }}-secret
spec:
  refreshInterval: {{ .refreshInterval | default "1h" }}
  secretStoreRef:
    name: {{ $.Values.externalSecrets.name }}-store
    kind: SecretStore
  target:
    name: {{ .name }}
    creationPolicy: Owner
    template:
      type: {{ .type | default "Opaque" }}

  data:
    {{- range .data }}
    - secretKey: {{ .name }}
      remoteRef:
        key: {{ .providerKey | quote }}
        property: {{ .providerProperty | quote }}
    {{- end }}
---
{{- end }}
{{- end }}

{{- define "library-chart.external-secret" -}}
{{- include "library-chart.external-secret.tpl" . -}}
{{- end -}}