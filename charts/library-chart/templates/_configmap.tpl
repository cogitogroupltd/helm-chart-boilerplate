{{- define "library-chart.configmap.tpl" -}}
{{- if .Values.configmap.enabled }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "library-chart.fullname" . }}-config
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  namespace: {{ .Release.Namespace }}
  annotations:
    {{- include "library-chart.annotations" . | nindent 4 }}
data:
  {{- range $key, $value := .Values.configmap.data }}
  {{ $key }}: {{ $value | quote }}
  {{- end }}
{{- end }}
{{- end -}}

{{- define "library-chart.configmap" -}}
{{- include "library-chart.configmap.tpl" . -}}
{{- end -}}
