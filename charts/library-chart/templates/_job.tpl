{{- define "library-chart.job.tpl" -}}
apiVersion: batch/v1
kind: Job
metadata:
  name : {{ include "library-chart.fullname" . }}-{{ randNumeric 8 }}
  annotations:
    {{- include "library-chart.annotations" . | nindent 4 }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  namespace: {{ .Release.Namespace }}
spec:
  template:
    metadata:
      labels:
        {{- include "library-chart.labels" . | nindent 12 }}
      annotations:
        {{- include "library-chart.annotations" . | nindent 12 }}
    spec:
      restartPolicy: {{ .Values.restartPolicy | default "OnFailure" }}
      {{- if and .Values.serviceAccount .Values.serviceAccount.name }}
      serviceAccountName: {{ .Values.serviceAccount.name }}
      {{- end }}
      automountServiceAccountToken: {{ .Values.automountServiceAccountToken | default true }}
      {{- if .Values.image.secrets}}
      imagePullSecrets:
        {{- toYaml .Values.image.secrets | nindent 12 }}
      {{- end }}
      {{- if .Values.initContainers }}
      initContainers:
        {{- range $key, $value := .Values.initContainers }}
        {{- include "library-chart.containers" $value | nindent 12 }}
        {{- end }}
      {{- end }}
      {{- if .Values.volumes}}
      volumes:
        {{- toYaml .Values.volumes | nindent 12 }}
      {{- end }}
      containers:
        {{- include "library-chart.containers" .Values.image | nindent 12 }}
        {{- if .Values.image.sidecars }}
        {{- range $key, $value := .Values.image.sidecars }}
        {{- include "library-chart.containers" $value | nindent 12 }}
        {{- end }}
        {{- end }}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 12 }}
      {{- end }}
      {{- if .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 12 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 12 }}
      {{- end }}
{{- end -}}

{{- define "library-chart.cronjob" -}}
{{- include "library-chart.cronjob.tpl" . -}}
{{- end -}}