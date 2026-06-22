# terraform-dashtag-vehicle

An opinionated Terraform module that creates a DashTag **vehicle** and, in one
step, its standard photo **album set** plus any **maintenance records** and
**modifications**. Composes
[`vehicle-album-set`](https://registry.terraform.io/modules/Dashtag-Platforms-Inc/vehicle-album-set/dashtag),
[`vehicle-maintenance`](https://registry.terraform.io/modules/Dashtag-Platforms-Inc/vehicle-maintenance/dashtag),
and [`vehicle-modification`](https://registry.terraform.io/modules/Dashtag-Platforms-Inc/vehicle-modification/dashtag).

Vehicles are owned by the API token's user. (Community-owned vehicles aren't
supported by the provider yet; when they are, this module will gain an `owner`
input rather than forking into a separate module.)

## Usage

```hcl
module "supra" {
  source  = "Dashtag-Platforms-Inc/vehicle/dashtag"
  version = "~> 0.1"

  make  = "Toyota"
  model = "Supra"
  year  = 1998

  # Standard albums are created by default; override or disable:
  # create_standard_albums = false
  albums = {
    exterior = { name = "Exterior" }
    engine   = { name = "Engine Bay" }
  }

  maintenance = {
    oil_2026 = {
      service_type   = "oil_change"
      service_name   = "Oil change"
      description     = "Full synthetic"
      performed_date = "2026-05-15"
      mileage        = 84000
    }
  }

  modifications = {
    turbo = {
      name           = "Single turbo conversion"
      description     = "BorgWarner EFR"
      installed_date = "2026-05-01"
      category       = "engine"
    }
  }
}
```

See [`examples/complete`](./examples/complete) for a runnable example.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_dashtag"></a> [dashtag](#requirement\_dashtag) | >= 0.1.0, < 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_dashtag"></a> [dashtag](#provider\_dashtag) | 0.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_albums"></a> [albums](#input\_albums) | Albums to create (when create\_standard\_albums). `null` (the default) uses the standard set; pass a map to override. | <pre>map(object({<br/>    name       = string<br/>    sort_order = optional(number)<br/>  }))</pre> | `null` | no |
| <a name="input_color"></a> [color](#input\_color) | Primary color. | `string` | `null` | no |
| <a name="input_create_standard_albums"></a> [create\_standard\_albums](#input\_create\_standard\_albums) | Create the `albums` set for this vehicle. Set false to skip albums. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Free-text description. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to create nothing (the create-gate convention). | `bool` | `true` | no |
| <a name="input_for_sale"></a> [for\_sale](#input\_for\_sale) | Whether the vehicle is listed for sale. | `bool` | `null` | no |
| <a name="input_listed_price"></a> [listed\_price](#input\_listed\_price) | Listed price when for sale. | `number` | `null` | no |
| <a name="input_maintenance"></a> [maintenance](#input\_maintenance) | Maintenance/service records to create, keyed by label. `null`/omitted creates none. | <pre>map(object({<br/>    service_type    = string<br/>    service_name    = string<br/>    description     = string<br/>    performed_date  = string<br/>    mileage         = number<br/>    labor_cost      = optional(number)<br/>    parts_cost      = optional(number)<br/>    technician_name = optional(string)<br/>    parts_used = optional(list(object({<br/>      name        = string<br/>      quantity    = number<br/>      brand       = optional(string)<br/>      part_number = optional(string)<br/>      unit_price  = optional(number)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_make"></a> [make](#input\_make) | Vehicle make, e.g. Toyota. | `string` | n/a | yes |
| <a name="input_mileage"></a> [mileage](#input\_mileage) | Odometer reading. | `number` | `null` | no |
| <a name="input_model"></a> [model](#input\_model) | Vehicle model, e.g. Supra. | `string` | n/a | yes |
| <a name="input_modifications"></a> [modifications](#input\_modifications) | Modifications to create, keyed by label. `null`/omitted creates none. | <pre>map(object({<br/>    name                 = string<br/>    description          = string<br/>    installed_date       = string<br/>    category             = optional(string)<br/>    installed_at_mileage = optional(number)<br/>    labor_cost           = optional(number)<br/>    parts_cost           = optional(number)<br/>  }))</pre> | `null` | no |
| <a name="input_nickname"></a> [nickname](#input\_nickname) | Display nickname. | `string` | `null` | no |
| <a name="input_trim"></a> [trim](#input\_trim) | Trim level. | `string` | `null` | no |
| <a name="input_vin"></a> [vin](#input\_vin) | Vehicle identification number. | `string` | `null` | no |
| <a name="input_year"></a> [year](#input\_year) | Model year. | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_album_ids"></a> [album\_ids](#output\_album\_ids) | Map of album label to its album ID. |
| <a name="output_maintenance_ids"></a> [maintenance\_ids](#output\_maintenance\_ids) | Map of maintenance label to its record ID. |
| <a name="output_modification_ids"></a> [modification\_ids](#output\_modification\_ids) | Map of modification label to its ID. |
| <a name="output_vehicle"></a> [vehicle](#output\_vehicle) | The created vehicle resource. |
| <a name="output_vehicle_id"></a> [vehicle\_id](#output\_vehicle\_id) | The created vehicle's ID. |
<!-- END_TF_DOCS -->

## Testing

```bash
make validate                      # terraform fmt + validate
DASHTAG_API_TOKEN=dt_… make test   # Terratest: real apply + destroy
```

## License

[Apache 2.0](./LICENSE).
