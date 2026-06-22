resource "dashtag_vehicle" "this" {
  count = var.enabled ? 1 : 0

  make         = var.make
  model        = var.model
  year         = var.year
  trim         = var.trim
  color        = var.color
  nickname     = var.nickname
  vin          = var.vin
  mileage      = var.mileage
  description  = var.description
  for_sale     = var.for_sale
  listed_price = var.listed_price
}

locals {
  vehicle_id = one(dashtag_vehicle.this[*].id)

  standard_albums = {
    exterior       = { name = "Exterior" }
    interior       = { name = "Interior" }
    engine_bay     = { name = "Engine Bay" }
    wheels_tires   = { name = "Wheels & Tires" }
    build_progress = { name = "Build Progress" }
  }

  # null inputs fall back to sensible defaults so callers (e.g. the garage
  # module) can forward optional values without juggling nulls.
  albums        = var.albums != null ? var.albums : local.standard_albums
  maintenance   = var.maintenance != null ? var.maintenance : {}
  modifications = var.modifications != null ? var.modifications : {}
}

module "albums" {
  source  = "Dashtag-Platforms-Inc/vehicle-album-set/dashtag"
  version = "~> 0.1"

  enabled    = var.enabled && var.create_standard_albums
  vehicle_id = local.vehicle_id
  albums     = local.albums
}

module "maintenance" {
  source  = "Dashtag-Platforms-Inc/vehicle-maintenance/dashtag"
  version = "~> 0.1"

  enabled    = var.enabled && length(local.maintenance) > 0
  vehicle_id = local.vehicle_id
  records    = local.maintenance
}

module "modifications" {
  source  = "Dashtag-Platforms-Inc/vehicle-modification/dashtag"
  version = "~> 0.1"

  enabled       = var.enabled && length(local.modifications) > 0
  vehicle_id    = local.vehicle_id
  modifications = local.modifications
}
