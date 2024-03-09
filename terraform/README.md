# n3t.uk GitHub Terraform Configuration

A [Terraform][terraform] repository for the management of [GitHub][github]
repositories for the [`n3tuk`][n3tuk] Organisation.

[terraform]: https://terraform.io/
[github]: https://github.com/
[n3tuk]: https://github.com/n3tuk

<!-- terraform-docs-start -->
<!-- prettier-ignore-start -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_iam_workload_identity_pool.github_workflows](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.github_actions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_service_account.github_workflows_tfstate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.github_workflows_tfstate_infra](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_iam_member.github_workflows_tfstate_n3tuk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_storage_bucket_iam_policy.terraform_states_tfstate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_policy) | resource |
| [google_iam_policy.tfstate](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/iam_policy) | data source |
| [google_storage_bucket.terraform_states](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket) | data source |

## Inputs

No inputs.

## Outputs

No outputs.

<!-- prettier-ignore-end -->
<!-- terraform-docs-end -->
