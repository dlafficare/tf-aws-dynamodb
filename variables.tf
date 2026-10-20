variable "service_name" {
  description = "The name of the service. Used for DynamoDB table naming. 3-255 characters: letters, numbers, hyphens, underscores and dots."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{3,255}$", var.service_name))
    error_message = "Service name must be 3-255 characters: letters, numbers, hyphens, underscores and dots."
  }
}

variable "performance_profile" {
  description = "The performance tier selected by the developer (sandbox, development, production). Point-in-time recovery and deletion protection are automatically configured based on this profile."
  type        = string

  validation {
    condition     = contains(["sandbox", "development", "production"], var.performance_profile)
    error_message = "Performance profile must be one of: sandbox, development, production."
  }
}

variable "partition_key" {
  description = "The name of the partition (hash) key attribute. Stored as a string."
  type        = string
  default     = "pk"
}

variable "additional_tags" {
  description = "Additional tags to apply, as a JSON object (e.g. {\"team\": \"backend\"})."
  type        = any
  default     = {}
}
