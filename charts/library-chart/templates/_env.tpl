{{- define "library-chart.envs" -}}
{{- if .fromSecret }}
{{- range .fromSecret }}
- name: {{ .name }}
  valueFrom:
    secretKeyRef:
      name: {{ .secret.name }}
      key: {{ .secret.key }}
      optional: {{ .secret.isOptional | default false  }}
{{- end }}
{{- end }}
{{- range .standard }}
- name: {{ .name }}
  value: {{ .value | quote }}
{{- end }}
{{- end }}