resource "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_cache_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = "Basic"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"
  redis_version       = var.redis_version
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "redis_configuration" {
    for_each = var.redis_configuration
    content {
      aof_backup_enabled              = redis_configuration.value.aof_backup_enabled
      aof_storage_connection_string_0 = redis_configuration.value.aof_storage_connection_string_0
    }
  }

  dynamic "identity" {
    for_each = var.system_assigned_identity ? [1] : []
    content {
      type = var.managed_identities
    }
  }

  dynamic "patch_schedule" {
    for_each = var.patch_schedule
    content {
      day_of_week        = patch_schedule.value.day_of_week
      start_hour_utc     = patch_schedule.value.start_hour_utc
      maintenance_window = patch_schedule.value.maintenance_window
    }
  }
}
