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
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.19 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_infra_github"></a> [infra\_github](#module\_infra\_github) | ../modules/repository | n/a |
| <a name="module_infra_vault"></a> [infra\_vault](#module\_infra\_vault) | ../modules/repository | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

<!-- prettier-ignore-end -->
<!-- terraform-docs-end -->
