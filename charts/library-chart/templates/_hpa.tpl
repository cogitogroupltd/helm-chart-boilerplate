{{ define "library-chart.hpa.tpl" -}}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "library-chart.fullname" . }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  namespace: {{ .Release.Namespace }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "library-chart.fullname" . }}
  minReplicas: {{ .Values.autoscaling.minReplicas }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas }}
  behavior:
    scaleUp:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleUpTime | default 0 }}
    scaleDown:
      stabilizationWindowSeconds: {{ .Values.autoscaling.scaleDownTime | default 15 }}
  metrics:
    {{- if .Values.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage | default 80 }}
    {{- end }}
    {{- if .Values.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetMemoryUtilizationPercentage | default 80 }}
    {{- end }}
{{- end }}

{{- define "library-chart.hpa" -}}
{{- include "library-chart.hpa.tpl" . -}}
{{- end -}}
