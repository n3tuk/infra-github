# n3t.uk GitHub Repository Terraform Module

<!-- terraform-docs-start -->
<!-- prettier-ignore-start -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.19 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.0 |
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5.19 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_environment_variable.gcp_service_account](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_environment_variable.gcp_workload_identity_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) | resource |
| [github_actions_variable.gcp_service_account](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_actions_variable.gcp_workload_identity_provider](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_dependabot_security_updates.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_dependabot_security_updates) | resource |
| [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) | resource |
| [github_repository_ruleset.main_branch_protection](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) | resource |
| [google_iam_workload_identity_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.deployment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_iam_workload_identity_pool_provider.integration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_service_account.deployment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.integration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.deployment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.integration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_member.deployment_read](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.deployment_write](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_iam_member.integration_read](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [random_id.deployment](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_id.integration](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_pet.workload](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [google_storage_bucket.tfstate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name (not Organization) for this GitHub repository | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description for this GitHub repository | `string` | `""` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | A list of all the environments which will be deployed to by this repository | `list(string)` | `[]` | no |
| <a name="input_google_project"></a> [google\_project](#input\_google\_project) | The name or ID of the Google Project in which to create the access resources | `string` | `"genuine-caiman"` | no |
| <a name="input_required_status_checks"></a> [required\_status\_checks](#input\_required\_status\_checks) | A list all the status checks which must pass before a Pull Request can be merged | <pre>list(object({<br>    context        = string<br>    integration_id = optional(number, 0)<br>  }))</pre> | `[]` | no |
| <a name="input_terraform_state_bucket"></a> [terraform\_state\_bucket](#input\_terraform\_state\_bucket) | The name of the Storgae Bucket in GCP which will store Terraform state files | `string` | `"n3tuk-genuine-caiman-terraform-states"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_service_account_deployment_email"></a> [google\_service\_account\_deployment\_email](#output\_google\_service\_account\_deployment\_email) | The email address of the Deployment Service Account for the Workload Identity |
| <a name="output_google_service_account_integration_email"></a> [google\_service\_account\_integration\_email](#output\_google\_service\_account\_integration\_email) | The email address of the Integration Service Account for the Workload Identity |
| <a name="output_google_workload_identity_provider_deployment_id"></a> [google\_workload\_identity\_provider\_deployment\_id](#output\_google\_workload\_identity\_provider\_deployment\_id) | The ID of the Deployment Workload Identity Provider |
| <a name="output_google_workload_identity_provider_integration_id"></a> [google\_workload\_identity\_provider\_integration\_id](#output\_google\_workload\_identity\_provider\_integration\_id) | The ID of the Integrations Workload Identity Provider |

<!-- prettier-ignore-end -->
<!-- terraform-docs-end -->
