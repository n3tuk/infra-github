config {
  format     = "default"
  plugin_dir = "~/.tflint.d/plugins"
}

plugin "terraform" {
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
  version = "0.6.0"
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_documented_outputs" {
  enabled = true
}

# Using main.tf is not always the best option for managing resources and data
# sources within larger modules and Terraform configurations
rule "terraform_standard_module_structure" {
  enabled = false
}

# tflint cannot always traverse included Terraform Modules, which means it may
# not be aware of provider usage within Modules and so report a false negative
rule "terraform_unused_required_providers" {
  enabled = false
}
