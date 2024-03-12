# There is a limitation on the size of the IDs for both the Workload Identity
# Pool as well as the Service Account in Google Cloud, as such generate a random
# pair of names which can be used as the unique ID for these resources
resource "random_pet" "workload" {
  length    = 2
  separator = "-"

  keepers = {
    repository = var.name
  }
}

resource "random_id" "integration" {
  byte_length = 2

  keepers = {
    repository = var.name
  }
}

resource "random_id" "deployment" {
  byte_length = 2

  keepers = {
    repository = var.name
  }
}

resource "google_iam_workload_identity_pool" "this" {
  project = var.google_project

  workload_identity_pool_id = random_pet.workload.id

  display_name = "gh/${substr(var.name, 0, 29)}"
  description  = <<-EOT
    A Workload Identity Pool for GitHub Workflows running within the
    n3tuk/${var.name} repository, allowing them to access Terraform
    state files and associated services in Google Cloud Storage.
  EOT
}

resource "google_iam_workload_identity_pool_provider" "integration" {
  project = var.google_project

  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = "integration"

  display_name = "GitHub Integration Workflows"
  description  = "GitHub Identity Provider for GitHub Workflows running Integration Events"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Map keys from the inbound OIDC JWT token to attributes within this Pool
  attribute_mapping = {
    "google.subject"         = "assertion.sub"
    "attribute.organization" = "assertion.repository_owner"
    "attribute.repository"   = "assertion.repository"
  }

  # Ensure that only the GitHub repository specifically being created being
  # configured under the n3tuk Organization will be permitted to access this
  # Workload Identity
  attribute_condition = <<-EOT
    attribute.repository == "n3tuk/${var.name}"
  EOT
}

resource "google_service_account" "integration" {
  project = var.google_project

  account_id   = "${random_pet.workload.id}-${random_id.integration.hex}"
  display_name = "GitHub Integration Workflow for n3tuk/${var.name}"
  description  = <<-EOT
    A Service Account to allow GitHub Workflows within the repository
    n3tuk/${var.name} to access and manage Terraform State files during
    Continious Integration.
  EOT
}

resource "google_service_account_iam_member" "integration" {
  service_account_id = google_service_account.integration.id
  role               = "roles/iam.workloadIdentityUser"

  member = format(
    "principalSet://iam.googleapis.com/%s/attribute.repository/%s",
    google_iam_workload_identity_pool.this.name, var.name
  )
}

resource "google_iam_workload_identity_pool_provider" "deployment" {
  project = var.google_project

  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = "deployment"

  display_name = "GitHub Deployment Workflows"
  description  = "GitHub Identity Provider for GitHub Workflows running Deployment Events"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Map keys from the inbound OIDC JWT token to attributes within this Pool
  attribute_mapping = {
    "google.subject"         = "assertion.sub"
    "attribute.organization" = "assertion.repository_owner"
    "attribute.repository"   = "assertion.repository"
    "attribute.environment"  = "assertion.sub.contains(\":environment:\") ? assertion.environment : \"unknown\""
  }

  # Ensure that only the specific GitHub repository being created under the
  # n3tuk Organization, and when an environment has been set in the assertion,
  # will be permitted to access this Workload Identity
  attribute_condition = <<-EOT
    attribute.repository == "n3tuk/${var.name}" &&
    attribute.environment != "unknown"
  EOT
}

resource "google_service_account" "deployment" {
  project = var.google_project

  account_id   = "${random_pet.workload.id}-${random_id.deployment.hex}"
  display_name = "GitHub Deployment Workflow for n3tuk/${var.name}"
  description  = <<-EOT
    A Service Account to allow GitHub Workflows within the repository
    n3tuk/${var.name} to access and manage Terraform State files during
    Deployments.
  EOT
}

resource "google_service_account_iam_member" "deployment" {
  service_account_id = google_service_account.deployment.id
  role               = "roles/iam.workloadIdentityUser"

  member = format(
    "principalSet://iam.googleapis.com/%s/attribute.repository/%s",
    google_iam_workload_identity_pool.this.name, var.name
  )
}

data "google_storage_bucket" "tfstate" {
  name = var.terraform_state_bucket
}

# Only use _member here as other repository and services are expected to
# provide their own access to the Storage Bucket, so cannot be overridden;
# nothing in this Module can be authoritative for any role or policy
resource "google_storage_bucket_iam_member" "integration_read" {
  bucket = data.google_storage_bucket.tfstate.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.integration.email}"
}

resource "google_storage_bucket_iam_member" "deployment_read" {
  bucket = data.google_storage_bucket.tfstate.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.deployment.email}"
}

resource "google_storage_bucket_iam_member" "deployment_write" {
  bucket = data.google_storage_bucket.tfstate.name
  role   = "roles/storage.objectUser"
  member = "serviceAccount:${google_service_account.deployment.email}"

  condition {
    title       = "tfstate-write-access"
    description = "Write access for n3tuk/${var.name} state files"
    expression  = <<EOT
      resource.type == "storage.googleapis.com/Object" &&
      resource.name.startsWith("projects/_/buckets/${data.google_storage_bucket.tfstate.name}/objects/") &&
      resource.name.extract("projects/_/buckets/${data.google_storage_bucket.tfstate.name}/objects/github/{name}").startsWith("n3tuk/${var.name}/")
    EOT
  }
}
