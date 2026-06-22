variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to create nothing (the create-gate convention)."
}

# --- Vehicle attributes -----------------------------------------------------

variable "make" {
  type        = string
  description = "Vehicle make, e.g. Toyota."
}

variable "model" {
  type        = string
  description = "Vehicle model, e.g. Supra."
}

variable "year" {
  type        = number
  description = "Model year."
  default     = null
}

variable "trim" {
  type        = string
  description = "Trim level."
  default     = null
}

variable "color" {
  type        = string
  description = "Primary color."
  default     = null
}

variable "nickname" {
  type        = string
  description = "Display nickname."
  default     = null
}

variable "vin" {
  type        = string
  description = "Vehicle identification number."
  default     = null
}

variable "mileage" {
  type        = number
  description = "Odometer reading."
  default     = null
}

variable "description" {
  type        = string
  description = "Free-text description."
  default     = null
}

variable "for_sale" {
  type        = bool
  description = "Whether the vehicle is listed for sale."
  default     = null
}

variable "listed_price" {
  type        = number
  description = "Listed price when for sale."
  default     = null
}

variable "sold" {
  type        = bool
  description = "Whether the vehicle has been sold."
  default     = null
}

variable "sold_date" {
  type        = string
  description = "Date the vehicle was sold (ISO 8601)."
  default     = null
}

variable "sold_price" {
  type        = number
  description = "Price the vehicle sold for."
  default     = null
}

# --- Child resources --------------------------------------------------------

variable "create_standard_albums" {
  type        = bool
  default     = true
  description = "Create the `albums` set for this vehicle. Set false to skip albums."
}

variable "albums" {
  type = map(object({
    name       = string
    sort_order = optional(number)
  }))
  description = "Albums to create (when create_standard_albums). `null` (the default) uses the standard set; pass a map to override."
  default     = null
}

variable "maintenance" {
  type = map(object({
    service_type    = string
    service_name    = string
    description     = string
    performed_date  = string
    mileage         = number
    labor_cost      = optional(number)
    parts_cost      = optional(number)
    technician_name = optional(string)
    parts_used = optional(list(object({
      name        = string
      quantity    = number
      brand       = optional(string)
      part_number = optional(string)
      unit_price  = optional(number)
    })))
  }))
  description = "Maintenance/service records to create, keyed by label. `null`/omitted creates none."
  default     = null
}

variable "modifications" {
  type = map(object({
    name                 = string
    description          = string
    installed_date       = string
    category             = optional(string)
    installed_at_mileage = optional(number)
    labor_cost           = optional(number)
    parts_cost           = optional(number)
  }))
  description = "Modifications to create, keyed by label. `null`/omitted creates none."
  default     = null
}
