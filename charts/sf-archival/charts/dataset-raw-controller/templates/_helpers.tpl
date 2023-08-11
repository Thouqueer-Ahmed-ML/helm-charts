{{/*
Expand the name of the chart.
*/}}
{{- define "dataset-raw-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dataset-raw-controller.fullname" -}}
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

{{- define "orc-event-controller.fullname" -}}
{{- printf "%s-%s" .Release.Name "orc-event-controller" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dataset-raw-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dataset-raw-controller.labels" -}}
app.kubernetes.io/name: {{ include "dataset-raw-controller.name" . }}
helm.sh/chart: {{ include "dataset-raw-controller.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "dataset-raw-controller.ingest-controller.fullname" -}}
{{- printf "%s-%s" .Release.Name "ingest-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "dataset-raw-controller.dataset-controller.fullname" -}}
{{- printf "%s-%s" .Release.Name "dataset-controller" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "dataset-raw-controller.postgresql.fullname" -}}
{{- if .Values.global.postgresql.host }} 
{{- printf "%s" .Values.global.postgresql.host -}}
{{- else }}
{{- printf "%s-%s" .Release.Name "postgresql" | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end -}}
