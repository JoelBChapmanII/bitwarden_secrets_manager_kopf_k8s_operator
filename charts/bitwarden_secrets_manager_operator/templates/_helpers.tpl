{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden_secrets_manager_operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bitwarden_secrets_manager_operator.fullname" -}}
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
{{- define "bitwarden_secrets_manager_operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bitwarden_secrets_manager_operator.labels" -}}
helm.sh/chart: {{ include "bitwarden_secrets_manager_operator.chart" . }}
{{ include "bitwarden_secrets_manager_operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bitwarden_secrets_manager_operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitwarden_secrets_manager_operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bitwarden_secrets_manager_operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bitwarden_secrets_manager_operator.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "bwsm-sa" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
