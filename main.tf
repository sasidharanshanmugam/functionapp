resource "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_cache-name
  location            = var.location
  resource_group_name = var.resource_group.name
  capacity            = var.capacity
  family              = var.family
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  redis_version       = var.redis_version 
  public_network_access_enabled = var.public_network_access_enabled
  dynamic "redis_configuration" {
    for_each = var.redis_configuration ? [1]:[]
    content {
      aof_backup_enabled = false
      aof_storage_connection_string_0 = null
    }
  }
   dynamic "identity" {
    for_each = var.system_assigned_identity ? [1]:[]
    content {
      type         = var.managed_identities
    }
  }
  dynamic "patch_schedule" {
    for_each = var.patch_schedule ? [1]:[]
    content {
      day_of_week = "Monday"
      start_hour_utc = 0
      maintenance_window  = "PT5H"
    }
  }
}
