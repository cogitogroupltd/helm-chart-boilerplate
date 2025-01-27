{{- define "library-chart.deployment.tpl" -}}
{{- if eq .Values.type "deployment"}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name : {{ include "library-chart.fullname" . }}
  annotations:
    {{- include "library-chart.annotations" . | nindent 4 }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  namespace: {{ .Release.Namespace }}
spec:
  replicas: {{ .Values.replicaCount | default 1 }}
  selector:
    matchLabels:
      {{- include "library-chart.selectorLabels" . | nindent 6}}
  {{- if .Values.updateStrategy }}
  strategy: {{- toYaml .Values.updateStrategy | nindent 4 }}
  {{- end }}
  template:
    metadata:
      labels:
        {{- include "library-chart.labels" . | nindent 8 }}
      annotations:
        {{- include "library-chart.annotations" . | nindent 8 }}
    spec:
      {{- if and .Values.serviceAccount .Values.serviceAccount.name }}
      serviceAccountName: {{ .Values.serviceAccount.name }}
      {{- end }}
      automountServiceAccountToken: {{ .Values.automountServiceAccountToken | default true }}
      {{- if .Values.image.secrets}}
      imagePullSecrets:
        {{- toYaml .Values.image.secrets | nindent 8 }}
      {{- end }}
      {{- if .Values.initContainers }}
      initContainers:
        {{- range $key, $value := .Values.initContainers }}
        {{- include "library-chart.containers" $value | nindent 8 }}
        {{- end }}
      {{- end }}
      {{- if .Values.securityContext }}
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8}}
      {{- end }}
      {{- if .Values.volumes}}
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
      {{- end }}
      containers:
        {{- include "library-chart.containers" .Values.image | nindent 8 }}
        {{- if .Values.image.sidecars }}
        {{- range $key, $value := .Values.image.sidecars }}
        {{- include "library-chart.containers" $value | nindent 8 }}
        {{- end }}
        {{- end }}
      {{- if .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml .Values.nodeSelector | nindent 8 }}
      {{- end }}
      {{- if .Values.affinity }}
      affinity:
        {{- toYaml .Values.affinity | nindent 8 }}
      {{- end }}
      {{- if .Values.tolerations }}
      tolerations:
        {{- toYaml .Values.tolerations | nindent 8 }}
      {{- end }}
{{- end -}}
{{- end -}}

{{- define "library-chart.deployment" -}}
{{- include "library-chart.deployment.tpl" . -}}
{{- end -}}