provider "google" {
  project = "genuine-caiman"
  region  = "europe-west2"
}

resource "google_iam_workload_identity_pool" "github_workflows" {
  project = "genuine-caiman"

  workload_identity_pool_id = "n3tuk-github-workflows"

  display_name = "GitHub Workflows for n3tuk"
  description  = <<EOT
    A Workload Identity Pool to permit access from GitHub Workflows running for
    n3tuk Repositories to Terraform State files and associated services in
    Google Cloud Storage Buckets
  EOT
}

resource "google_iam_workload_identity_pool_provider" "github_actions" {
  project = "genuine-caiman"

  workload_identity_pool_id          = google_iam_workload_identity_pool.github_workflows.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"

  display_name = "GitHub Actions"
  description  = "GitHub Actions Identity Provider for GitHub Workflows"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  # Map keys from the inboud OIDC JWT token to attributes within this Workload
  # Identity Pool
  attribute_mapping = {
    "google.subject"         = "assertion.sub"
    "attribute.organization" = "assertion.repository_owner"
    "attribute.event"        = "assertion.event_name"
    "attribute.actor"        = "assertion.actor"
    "attribute.repository"   = "assertion.repository"
    "attribute.ref_type"     = "assertion.ref_type"
    "attribute.ref"          = "assertion.ref"
    "attribute.environment"  = "assertion.sub.contains(\":environment:\") ? assertion.environment : \"unknown\""
  }

  # Ensure that only principals under the n3tuk Organization in GitHub will be
  # permitted to access this Workload Identity, otherwise all repositories under
  # all Organizations will be allowed to
  attribute_condition = "attribute.organization == \"n3tuk\""
}

resource "google_service_account" "github_workflows_tfstate" {
  project = "genuine-caiman"

  account_id   = "github-workflows-tfstate"
  display_name = "Terraform State Service Account for GitHub Workflows"
  description  = <<EOT
    Provide a Service Account which will allow GitHub Repositories, connecting
    to Google Cloud via OIDC, permission to access and manage Terraform State
    files
  EOT
}

resource "google_service_account_iam_member" "github_workflows_tfstate_n3tuk" {
  service_account_id = google_service_account.github_workflows_tfstate.id
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_workflows.name}/attribute.organization/n3tuk"
}

resource "google_service_account_iam_member" "github_workflows_tfstate_infra" {
  service_account_id = google_service_account.github_workflows_tfstate.id
  role               = "roles/iam.workloadIdentityUser"

  member = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_workflows.name}/attribute.repository/n3tuk/infra-*"
}

resource "google_storage_bucket_iam_policy" "terraform_states_tfstate" {
  bucket      = data.google_storage_bucket.terraform_states.name
  policy_data = data.google_iam_policy.tfstate.policy_data
}

data "google_storage_bucket" "terraform_states" {
  name = "n3tuk-genuine-caiman-terraform-states"
}

data "google_iam_policy" "tfstate" {
  # Permit the github-workflows-terraform Service Account to have full
  # read/write access to the Google Storage Bucket for Terraform States as this
  # bucket is for the storage of those .tfstate files, as well as for access to
  # them via the terraform_remote_state data sources
  binding {
    role = "roles/storage.objectUser"

    members = [
      "serviceAccount:${google_service_account.github_workflows_tfstate.email}",
    ]
  }
}
