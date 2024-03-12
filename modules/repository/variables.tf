variable "name" {
  description = "The name (not Organization) for this GitHub repository"
  type        = string
  nullable    = false
}

variable "description" {
  description = "The description for this GitHub repository"
  type        = string
  default     = ""
  nullable    = false
}

variable "required_status_checks" {
  description = "A list all the status checks which must pass before a Pull Request can be merged"
  type = list(object({
    context        = string
    integration_id = optional(number, 0)
  }))
  default  = []
  nullable = false
}

variable "environments" {
  description = "A list of all the environments which will be deployed to by this repository"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "terraform_state_bucket" {
  description = "The name of the Storgae Bucket in GCP which will store Terraform state files"
  type        = string
  default     = "n3tuk-genuine-caiman-terraform-states"
  nullable    = false
}

variable "google_project" {
  description = "The name or ID of the Google Project in which to create the access resources"
  type        = string
  default     = "genuine-caiman"
  nullable    = false
}
