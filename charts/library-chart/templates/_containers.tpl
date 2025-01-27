{{/*
common template for containers
@param .root the root scope
@param .image the scope of the image
*/}}
{{- define "library-chart.containers" -}}
- name: {{ required "Container name is required" .name  }}
  {{- if .securityContext }}
  securityContext:
    {{- toYaml .securityContext | nindent 4 }}
  {{- end }}
  image: "{{ required "Container Image is required" .repository }}:{{ default "latest" .tag }}"
  imagePullPolicy: {{ .pullPolicy }}
  {{- if .command }}
  command:
  {{- range .command  }}
    - {{ . | quote }}
  {{- end }}
  {{- end }}
  {{- if .args }}
  args:
  {{- range .args  }}
    - {{ . | quote }}
  {{- end }}
  {{- end }}
  {{- if .volumeMounts }}
  volumeMounts:
    {{- toYaml .volumeMounts | nindent 4 }}
  {{- end }}
  {{- if .envVars }}
  env:
  {{- include "library-chart.envs" .envVars | indent 4 -}}
  {{- end }}
  {{- if .ports }}
  ports:
    {{- toYaml .ports | nindent 4 }}
  {{- end }}
  {{- if .resources }}
  resources:
    {{- toYaml .resources | nindent 4 }}
  {{- end }}
  {{- if .livenessProbe }}
  livenessProbe:
    {{- toYaml .livenessProbe | nindent 4 }}
  {{- end }}
  {{- if .readinessProbe }}
  readinessProbe:
    {{- toYaml .readinessProbe | nindent 4 }}
  {{- end }}
{{- end -}}