terraform {
  required_version = "~> 1.7.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.19.0"
    }
  }

  backend "gcs" {
    bucket = "n3tuk-genuine-caiman-terraform-states"
    prefix = "github/n3tuk/infra-github"
  }
}

locals {}
