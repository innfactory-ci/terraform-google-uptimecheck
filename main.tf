locals {
  uptime_alert_name           = format("%s is down.", var.service_name)
  uptime_name                 = format("%s uptime check [global]", var.service_name)
  uptime_alert_condition_name = format("%s uptime check failed.", var.service_name)
}


resource "google_monitoring_uptime_check_config" "uptime_check" {
  display_name = local.uptime_name
  timeout      = "10s"
  period       = "60s"
  project      = var.project

  http_check {
    path         = var.path
    port         = var.port
    use_ssl      = var.use_ssl
    validate_ssl = var.validate_ssl
  }
  monitored_resource {
    type = "uptime_url"
    labels = {
      host       = var.service_url
      project_id = var.project
    }
  }
}

resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = local.uptime_alert_name
  project      = var.project
  combiner     = "OR"
  conditions {
    display_name = local.uptime_alert_condition_name
    condition_threshold {
      filter          = format("metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" resource.type=\"uptime_url\" resource.label.\"host\"=\"%s\"", var.service_url)
      duration        = "0s"
      comparison      = "COMPARISON_GT"
      threshold_value = 1
      trigger {
        count   = 1
        percent = 0
      }
      aggregations {
        alignment_period     = "1200s"
        cross_series_reducer = "REDUCE_COUNT_FALSE"
        group_by_fields = [
          "resource.*",
        ]
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
    }
  }
  documentation {
    content   = var.documentation
    mime_type = "text/markdown"
  }
  notification_channels = var.notification_channels
}
