{{- define "library-chart.annotations" -}}
{{- if .Values.commonAnnotations }}
{{- tpl (toYaml .Values.commonAnnotations) . }}
{{- else }}
{}
{{- end }}
{{- end -}}


