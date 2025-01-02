{{/*
Generates a random 32-char secret if an existing secret is not found
example usage:

    apiVersion: v1
    kind: Secret
    metadata:
        name: "my-secret"
    type: Opaque
    data:
        {{ $secretValue := include "library-chart.generateSecret" ( dict "name" $secretName "key" "password" "root" $ ) | trim }}
        my-password: {{ $secretValue | quote }}
*/}}

{{ define "library-chart.generateSecret" -}}

{{ $ := .root }}
{{ $secretName := .name }}
{{ $secretKey := .key }}
{{- $secret := (lookup "v1" "Secret" $.Release.Namespace $secretName) | default dict -}}
{{- $secretData := (get $secret "data") | default dict -}}
{{- $jwtSecret := (get $secretData $secretKey ) | default (randAlphaNum 32 | b64enc) -}}
{{ $jwtSecret | trim }}
{{ end }}