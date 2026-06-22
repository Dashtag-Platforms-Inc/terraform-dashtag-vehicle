output "vehicle_id" {
  description = "The created vehicle's ID."
  value       = local.vehicle_id
}

output "vehicle" {
  description = "The created vehicle resource."
  value       = one(dashtag_vehicle.this)
}

output "album_ids" {
  description = "Map of album label to its album ID."
  value       = module.albums.album_ids
}

output "maintenance_ids" {
  description = "Map of maintenance label to its record ID."
  value       = module.maintenance.maintenance_ids
}

output "modification_ids" {
  description = "Map of modification label to its ID."
  value       = module.modifications.modification_ids
}
