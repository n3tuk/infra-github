module "infra_github" {
  source = "../modules/repository"

  name        = "infra-github"
  description = <<-EOT
    The general, high-level Terraform configuration for GitHub, including the
    bootstrapping of basic GCP access for state management, and the creation and
    configuration of repositories and common resources.
  EOT

  environments = [
    "live",
  ]
}

module "infra_vault" {
  source = "../modules/repository"

  name        = "infra-vault"
  description = <<-EOT
    The general, high-level configuration for Vault, inclduing the bootstrapping
    of the Cluster configuration, and common service integrations and mounts.
  EOT

  environments = [
    "services",
    "development",
    "production",
  ]
}
