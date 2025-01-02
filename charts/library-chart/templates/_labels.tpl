{{- define "library-chart.commonLabels" -}}
{{- if .Values.commonLabels }}
{{- tpl (toYaml .Values.commonLabels) . }}
{{- end }}
{{- end -}}