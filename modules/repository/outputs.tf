output "google_workload_identity_provider_integration_id" {
  description = "The ID of the Integrations Workload Identity Provider"
  value       = google_iam_workload_identity_pool_provider.integration.id
}

output "google_service_account_integration_email" {
  description = "The email address of the Integration Service Account for the Workload Identity"
  value       = google_service_account.integration.email
}

output "google_workload_identity_provider_deployment_id" {
  description = "The ID of the Deployment Workload Identity Provider"
  value       = google_iam_workload_identity_pool_provider.deployment.id
}

output "google_service_account_deployment_email" {
  description = "The email address of the Deployment Service Account for the Workload Identity"
  value       = google_service_account.deployment.email
}
