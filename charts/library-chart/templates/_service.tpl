{{- define "library-chart.service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ include "library-chart.fullname" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort | default "http" }}
      protocol: {{ .Values.service.protocol | default "TCP" }}
      name: {{ .Values.service.name | default "http" }}
  {{- range .Values.service.additionalPorts }}
    - port: {{ .port }}
      targetPort: {{ .targetPort }}
      protocol: {{ .protocol | default "TCP" }}
      name: {{  .portName }}
  {{- end }}
  selector:
    {{- include "library-chart.selectorLabels" . | nindent 4 }}

{{- end -}}

{{- define "library-chart.service" -}}
{{- include "library-chart.service.tpl" . -}}
{{- end -}}