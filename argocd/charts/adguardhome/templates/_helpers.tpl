{{/* templates/_helpers.tpl */}}
{{- define "adguardhome.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "adguardhome.fullname" -}}
{{- $name := include "adguardhome.name" . -}}
{{- if .Release.Name }}{{ printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}{{ else }}{{ $name }}{{ end -}}
{{- end -}}
