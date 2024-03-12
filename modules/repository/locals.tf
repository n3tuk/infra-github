locals {
  # These are the Organization-installed applications which check all Pull
  # Requests on all repositories, and so should be enabled as required status
  # checks for all repositories configured with this Module
  default_required_status_checks = [
    {
      context = "GitGuardian Security Checks"
      # The integration_id only seems to work once the application has run a
      # status check against a Pull Request, so don't set the integration_id
      # integration_id = 46505
    },
    {
      context = "Summary"
      # integration_id = 10562
    },
  ]
}
