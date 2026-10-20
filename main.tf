# Map performance profiles to DynamoDB table configurations
locals {
  dynamodb_config = {
    sandbox = {
      point_in_time_recovery = false
      deletion_protection    = false
    }
    development = {
      point_in_time_recovery = true
      deletion_protection    = false
    }
    production = {
      point_in_time_recovery = true
      deletion_protection    = true
    }
  }

  tags = merge(
    {
      environment = var.performance_profile
      managed_by  = "terraform"
      service     = var.service_name
    },
    var.additional_tags
  )
}

# Create DynamoDB table (on-demand billing: no capacity planning, pay per request)
resource "aws_dynamodb_table" "main" {
  name         = var.service_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.partition_key

  attribute {
    name = var.partition_key
    type = "S"
  }

  point_in_time_recovery {
    enabled = local.dynamodb_config[var.performance_profile].point_in_time_recovery
  }

  # Encryption at rest with AWS owned key
  server_side_encryption {
    enabled = true
  }

  deletion_protection_enabled = local.dynamodb_config[var.performance_profile].deletion_protection

  tags = local.tags
}
