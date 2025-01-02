{{- define "library-chart.ingress.tpl" -}}
{{- $fullName := include "library-chart.fullname" . -}}
{{- $svcPort := .Values.service.port -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "library-chart.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  namespace: {{ .Release.Namespace }}
spec:
  {{- if and .Values.ingress.className (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion) }}
  ingressClassName: {{ .Values.ingress.className }}
  {{- end }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ .name | default (print $fullName ) }}
                port:
                  {{- if .portName }}
                  name: {{ .portName }}
                  {{- else }}
                  number: {{ .portNumber | default $svcPort }}
                  {{- end }}
          {{- end }}
    {{- end }}
{{- end -}}

{{- define "library-chart.ingress" -}}
{{- include "library-chart.ingress.tpl" . -}}
{{- end -}}