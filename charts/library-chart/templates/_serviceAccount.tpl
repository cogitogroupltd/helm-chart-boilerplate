{{- define "library-chart.serviceAccount.tpl" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .Values.serviceAccount.name | default (printf "%s-service-account" (include "library-chart.fullname" . )) }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  annotations:
    {{- $commonAnnotations := include "library-chart.annotations" . | fromYaml -}}
    {{- mergeOverwrite $commonAnnotations .Values.serviceAccount.annotations  | toYaml | nindent 4 -}}
{{- end -}}