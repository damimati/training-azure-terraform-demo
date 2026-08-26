# Create standard naming convention and tags
locals {
  # Base project identifiers
  project     = "superapp"
  environment = "dev"
  os1    = "lx"
  os2   = "win"
  location = "southafricanorth"

  # Standardized VM naming convention
  vm_name_win = "az-${local.project}${local.environment}${local.os2}vm"
  vm_name_lx = "az-${local.project}${local.environment}${local.os1}vm"
  generic_name = "${local.project}-${local.environment}"
  storage_name = "${local.project}${local.environment}matistrg01"

  # Common tags applied to all resources
  common_tags = {
    Project     = local.project
    Environment = local.environment
    Location    = local.location
    Owner       = "Dami Mati"
  }
}