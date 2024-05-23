variable "redis_cache_name" {
  description = "The name of the Redis cache."
  type        = string
  default     = "myRedisCache1998"
}

variable "location" {
  description = "The location where the Redis cache will be created."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "sasidharanpoc"
}

variable "capacity" {
  description = "The capacity of the Redis cache."
  type        = number
  default     = 1
}

variable "family" {
  description = "The family of the Redis cache."
  type        = string
  default     = "C"
}

variable "redis_version" {
  description = "The version of Redis."
  type        = string
  default     = "6"
}

variable "public_network_access_enabled" {
  description = "Flag to enable public network access."
  type        = bool
  default     = false
}

variable "system_assigned_identity" {
  description = "Flag to determine if system-assigned identity is enabled."
  type        = bool
  default     = true
}

variable "managed_identities" {
  description = "The type of managed identities."
  type        = string
  default     = "SystemAssigned"
}

variable "redis_configuration" {
  description = "List of Redis configuration settings."
  type = list(object({
    aof_backup_enabled              = bool
    aof_storage_connection_string_0 = string
  }))
  default = [
    {
      aof_backup_enabled              = false
      aof_storage_connection_string_0 = null
    }
  ]
}


variable "patch_schedule" {
  description = "Patch schedule settings."
  type        = list(object({
    day_of_week        = string
    start_hour_utc     = number
    maintenance_window = string
  }))
  default = [ {
    day_of_week        = "Monday"
    start_hour_utc     = 0
    maintenance_window = "PT5H"
}
]
}
