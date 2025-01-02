{{- define "library-chart.pvc.tpl" -}}
{{- range .Values.pvcs }}
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .name | default (include "library-chart.fullname" $) }}
  annotations:
    {{- include "library-chart.annotations" $ | nindent 4 }}
  labels:
    {{- include "library-chart.labels" $ | nindent 4 }}
  namespace: {{ $.Release.Namespace }} 
spec:
  accessModes:
    - {{ .accessModes | default "ReadWriteMany" }}
  {{- if .storageClassName }}
  storageClassName: {{ .storageClassName | default "standard" }}
  {{- end }}
  resources:
    requests:
      storage: {{ .size | default "2Gi" }}
---
{{- end }}
{{- end -}}

{{- define "library-chart.pvc" -}}
{{- include "library-chart.pvc.tpl" . -}}
{{- end -}}
