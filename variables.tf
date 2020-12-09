variable "documentation" {
  type        = string
  description = "Alert Documentation as markdown"
}

variable "notification_channels" {
  type        = list(string)
  description = "List of notification channels like slack or email."
}

variable "service_name" {
  type        = string
  description = "The name of the service which get's monitored."
}

variable "service_url" {
  type        = string
  description = "The Endpoint of the monitored service. e.g. innfactory.cloud"
}

variable "port" {
  description = "Service port."
  default     = "443"
}

variable "path" {
  description = "Service http(s) port"
  default     = "/"
}

variable "use_ssl" {
  description = "Use SSL."
  type        = bool
  default     = true
}

variable "validate_ssl" {
  description = "Validate SSL."
  type        = bool
  default     = true
}

variable "project" {
  description = "project id"
}