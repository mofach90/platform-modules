# Minimal caller: proves in CI that the module initialises and validates.
# Never applied; the values are placeholders.

terraform {
  required_version = ">= 1.9"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 8.0"
    }
  }
}

module "web" {
  source = "../../modules/vm-group"

  project_id      = "example-project"
  region          = "europe-west10"
  subnetwork      = "projects/example-project/regions/europe-west10/subnetworks/platform-europe-west10"
  snapshot_policy = "platform-daily"
  team            = "shop"
  env             = "dev"

  name           = "web"
  instance_count = 2
  size           = "small"
  image          = "debian-12"
}

output "instances" {
  description = "VM name → zone"
  value       = module.web.instances
}
