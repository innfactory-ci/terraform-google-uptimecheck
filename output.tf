output "uptime_id" {
  value = google_monitoring_uptime_check_config.uptime_check.id
}

output "uptime_name" {
  value = google_monitoring_uptime_check_config.uptime_check.name
}

output "alert_id" {
  value = google_monitoring_alert_policy.uptime_alert.id
}

output "alert_name" {
  value = google_monitoring_alert_policy.uptime_alert.name
}