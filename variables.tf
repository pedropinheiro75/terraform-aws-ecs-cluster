variable "container_insights_enabled" {
  description = "Whether or not to enable container insights"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container."
  type        = string
  default     = null
}

variable "logging" {
  description = "The AWS Key Management Service key ID to encrypt the data between the local client and the container. (Valid values: 'NONE', 'DEFAULT', 'OVERRIDE')"
  type        = string
  default     = "DEFAULT"
  validation {
    condition     = contains(["NONE", "DEFAULT", "OVERRIDE"], var.logging)
    error_message = "The 'logging' value must be one of 'NONE', 'DEFAULT', 'OVERRIDE'"
  }
}

variable "log_configuration" {
  description = "The log configuration for the results of the execute command actions Required when logging is OVERRIDE"
  type = object({
    cloud_watch_encryption_enabled = string
    cloud_watch_log_group_name     = string
    s3_bucket_name                 = string
    s3_key_prefix                  = string
  })
  default = null
}

variable "capacity_providers_fargate" {
  description = "Use FARGATE capacity provider"
  type        = bool
  default     = true
}

variable "capacity_providers_fargate_spot" {
  description = "Use FARGATE_SPOT capacity provider"
  type        = bool
  default     = false
}

variable "default_capacity_strategy" {
  description = "The capacity provider strategy to use by default for the cluster"
  type = object({
    base = object({
      provider = string
      value    = number
    })
    weights = map(number)
  })
  default = {
    base = {
      provider = "FARGATE"
      value    = 1
    }
    weights = {}
  }
}