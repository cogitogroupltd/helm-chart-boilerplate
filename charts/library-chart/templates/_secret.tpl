{{- define "library-chart.secret" -}}
{{- range $secret := .Values.secrets }}
{{- if $secret.name }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secret.name }}
  namespace: {{ $.Release.Namespace }}
  labels:
    {{- include "library-chart.labels" $ | nindent 4 }}
  annotations:
    {{- include "library-chart.annotations" $ | nindent 4 }}
type: {{ $secret.type | default "Opaque" }}
data:
  {{- range $key, $value := $secret.data }}
  {{ $key }}: {{ $value | b64enc | quote }}
  {{- end }}
{{- end }}
{{- end }}
{{- end -}}
