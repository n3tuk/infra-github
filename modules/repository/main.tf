provider "github" {
  owner = "n3tuk"
}

resource "github_repository" "this" {
  name        = var.name
  description = replace(var.description, "\n", "")

  visibility = "public"

  has_issues   = true
  has_projects = true

  has_wiki        = false
  has_discussions = false

  allow_merge_commit     = true
  allow_squash_merge     = false
  allow_rebase_merge     = false
  allow_update_branch    = true
  delete_branch_on_merge = true
  allow_auto_merge       = true

  merge_commit_title   = "PR_TITLE"
  merge_commit_message = "BLANK"

  archive_on_destroy = true

  vulnerability_alerts = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "enabled"
    }
  }

  lifecycle {
    ignore_changes = [template]
  }
}

resource "github_repository_dependabot_security_updates" "this" {
  repository = github_repository.this.id
  enabled    = true
}

resource "github_repository_ruleset" "main_branch_protection" {
  repository  = github_repository.this.name
  name        = "main-branch-protection"
  enforcement = "active"

  target = "branch"
  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    # Only allow the configured bypass users (normally no-one) permission to
    # create or delete the main branch on the repository
    creation = true
    deletion = true

    # Allow anyone with write permissions to update the main branch, but not
    # be allowed to force a push to it outside of pull requests
    update           = false
    non_fast_forward = false

    pull_request {
      required_approving_review_count = 0

      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = true
      require_last_push_approval        = true
      required_review_thread_resolution = true
    }

    # Allow merge commits, which are the only supported merge forms permitted on
    # the repository via the main configuration above
    required_linear_history = false

    # Require all commits to be signed
    required_signatures = true

    required_status_checks {
      strict_required_status_checks_policy = true

      dynamic "required_check" {
        for_each = concat(
          local.default_required_status_checks,
          var.required_status_checks
        )

        content {
          context        = required_check.value.context
          integration_id = lookup(required_check.value, "integration_id", 0)
        }
      }
    }

    required_deployments {
      required_deployment_environments = var.environments
    }
  }
}

resource "github_repository_environment" "this" {
  for_each = toset(var.environments)

  repository  = github_repository.this.name
  environment = each.key

  can_admins_bypass   = true
  prevent_self_review = false
}

resource "github_actions_variable" "gcp_service_account" {
  repository = github_repository.this.name

  variable_name = "GCP_SERVICE_ACCOUNT"
  value         = google_service_account.integration.email
}

resource "github_actions_variable" "gcp_workload_identity_provider" {
  repository = github_repository.this.name

  variable_name = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  value         = google_iam_workload_identity_pool_provider.integration.id
}

resource "github_actions_environment_variable" "gcp_service_account" {
  for_each = toset(var.environments)

  repository  = github_repository.this.name
  environment = github_repository_environment.this[each.key].environment

  variable_name = "GCP_SERVICE_ACCOUNT"
  value         = google_service_account.deployment.email
}

resource "github_actions_environment_variable" "gcp_workload_identity_provider" {
  for_each = toset(var.environments)

  repository  = github_repository.this.name
  environment = github_repository_environment.this[each.key].environment

  variable_name = "GCP_WORKLOAD_IDENTITY_PROVIDER"
  value         = google_iam_workload_identity_pool_provider.deployment.id
}
