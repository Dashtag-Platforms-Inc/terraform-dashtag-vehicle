terraform {
  required_providers {
    dashtag = {
      source = "Dashtag-Platforms-Inc/dashtag"
    }
  }
}

# Token comes from the DASHTAG_API_TOKEN environment variable.
provider "dashtag" {}

module "vehicle" {
  source = "../../"

  make  = "Terraform"
  model = "Vehicle Example"
  year  = 2024

  albums = {
    exterior = { name = "Exterior" }
    build    = { name = "Build Progress" }
  }

  maintenance = {
    oil = {
      service_type   = "oil_change"
      service_name   = "Oil change"
      description    = "Full synthetic + filter"
      performed_date = "2026-05-15"
      mileage        = 1000
    }
  }

  modifications = {
    intake = {
      name           = "Cold air intake"
      description    = "AEM dry-flow"
      installed_date = "2026-05-01"
      category       = "intake"
    }
  }
}

output "vehicle_id" {
  value = module.vehicle.vehicle_id
}

output "album_ids" {
  value = module.vehicle.album_ids
}

output "maintenance_ids" {
  value = module.vehicle.maintenance_ids
}

output "modification_ids" {
  value = module.vehicle.modification_ids
}
