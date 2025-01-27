{{- define "library-chart.external-secret-store.tpl" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    {{- toYaml .Values.externalSecrets.annotations | nindent 4 }}
  name: {{ .Values.externalSecrets.name  }}-sa

---
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: {{ .Values.externalSecrets.name }}-store
spec:
  provider:
    aws:
      service: SecretsManager
      region: {{ .Values.externalSecrets.region }}
      auth:
        jwt:
          serviceAccountRef:
            name: "{{ .Values.externalSecrets.name }}-sa"

{{- end }}

{{- define "library-chart.external-secret-store" -}}
{{- include "library-chart.external-secret-store.tpl" . -}}
{{- end -}}