{{/*
Expand the name of the chart.
*/}}
{{- define "middlemail.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "middlemail.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "middlemail.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "middlemail.labels" -}}
helm.sh/chart: {{ include "middlemail.chart" . }}
{{ include "middlemail.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "middlemail.selectorLabels" -}}
app.kubernetes.io/name: {{ include "middlemail.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
NOTE: This utility template is needed until https://github.com/helm/helm/issues/3920 is resolved.

Call a template from the context of a subchart.

Usage:
  {{ include "call-nested" (list . "<subchart_name>" "<subchart_template_name>") }}
*/}}
{{- define "call-nested" }}
{{- $dot := index . 0 }}
{{- $subchart := index . 1 | splitList "." }}
{{- $template := index . 2 }}
{{- $values := $dot.Values }}
{{- range $subchart }}
{{- $values = index $values . }}
{{- end }}
{{- include $template (dict "Chart" (dict "Name" (last $subchart)) "Values" $values "Release" $dot.Release "Capabilities" $dot.Capabilities) }}
{{- end }}

{{/*
The URI of the Elasticsearch instance
*/}}
{{- define "middlemail.elasticsearch.uri" -}}
{{- if .Values.elasticsearch.uri }}
{{- .Values.elasticsearch.uri }}
{{- else if .Values.elasticsearch.provision }}
{{- printf "http://%s:%s" (include "call-nested" (list . "elasticsearch" "elasticsearch.master.fullname")) (toString .Values.elasticsearch.master.service.port) }}
{{- else }}
{{ fail "elasticsearch.uri must be set when elasticsearch.provision is false" }}
{{- end }}
{{- end }}

{{/*
RabbitMQ hostname to connect to
*/}}
{{- define "middlemail.rabbitmq.host" }}
{{- if .Values.rabbitmq.host }}
{{- .Values.rabbitmq.host }}
{{- else if .Values.rabbitmq.provision }}
{{- include "call-nested" (list . "rabbitmq" "rabbitmq.fullname") }}
{{- else }}
{{- fail "rabbitmq.host must be set when rabbitmq.provision is false" }}
{{- end }}
{{- end }}

{{/*
Secret holding RabbitMQ password
*/}}
{{- define "middlemail.easynetq.secret" }}
{{- if .Values.rabbitmq.auth.existingPasswordSecret }}
{{- .Values.rabbitmq.auth.existingPasswordSecret }}
{{- else if .Values.rabbitmq.provision }}
{{- include "call-nested" (list . "rabbitmq" "rabbitmq.secretPasswordName") }}
{{- else }}
{{- fail "rabbitmq.auth.existingPasswordSecret must be set when rabbitmq.provision is false" }}
{{- end }}
{{- end }}

{{/*
EasyNetQ connection string for RabbitMQ; excluding the password
*/}}
{{- define "middlemail.easynetq.connectionstring" }}
{{- printf "host=%s;" (include "middlemail.rabbitmq.host" .) -}}
{{- if .Values.easynetq.virtualHost }}
{{- printf "virtualHost=%s;" .Values.easynetq.virtualHost -}}
{{- end }}
{{- printf "username=%s;" .Values.rabbitmq.auth.username -}}
{{- if .Values.easynetq.requestedHeartbeat }}
{{- printf "requestedHeartbeat=%s;" .Values.easynetq.requestedHeartbeat -}}
{{- end }}
{{- if .Values.easynetq.prefetchCount }}
{{- printf "prefetchCount=%s;" (toString .Values.easynetq.prefetchCount) -}}
{{- end }}
{{- if .Values.easynetq.publisherConfirms }}
{{- printf "publisherConfirms=%s;" .Values.easynetq.publisherConfirms -}}
{{- end }}
{{- if .Values.easynetq.persistentMessages }}
{{- printf "persistentMessages=%s;" .Values.easynetq.persistentMessages -}}
{{- end }}
{{- printf "product=%s;" (default "MiddleMail" .Values.easynetq.product) -}}
{{- if .Values.easynetq.platform }}
{{- printf "platform=%s;" .Values.easynetq.platform -}}
{{- end }}
{{- if .Values.easynetq.timeout }}
{{- printf "timeout=%s;" .Values.easynetq.timeout -}}
{{- end }}
{{- end }}

{{/*
We connect to a provided redis instance to safely track which messages from rabbitmq have been processed.
*/}}
{{- define "middlemail.redis.hostname" }}
{{- printf "%s-master" (include "call-nested" (list . "redis" "redis.fullname")) }}
{{- end }}

{{- define "middlemail.redis.secretName" }}
{{- include "call-nested" (list . "redis" "redis.secretName") }}
{{- end }}

{{- define "middlemail.redis.secretPasswordKey" }}
{{- include "call-nested" (list . "redis" "redis.secretPasswordKey") }}
{{- end }}
