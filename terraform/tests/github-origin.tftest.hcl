# Verify that any OIDC configuration for the GitHub Workflow provider for the
# Workload Identity only targets GitHub Actions, and fail otherwise
run "valid_workload_identity_provider" {
  command = plan

  assert {
    condition     = google_iam_workload_identity_pool_provider.github_actions.oidc[0].issuer_uri == "https://token.actions.githubusercontent.com"
    error_message = "Only GitHub Actions are permitted for this Workload Identity"
  }
}
