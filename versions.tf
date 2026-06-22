terraform {
  required_version = ">= 1.5"

  required_providers {
    dashtag = {
      source  = "Dashtag-Platforms-Inc/dashtag"
      version = ">= 0.1.0, < 1.0.0"
    }
  }
}
