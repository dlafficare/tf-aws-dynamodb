# tf-aws-dynamodb

On-demand DynamoDB table, encrypted at rest. Point-in-time recovery and deletion protection depend on the performance profile.

Part of the Mia-Platform Console demo for AWS: the module is consumed by a Software Catalog item (custom resource) and applied through HCP Terraform by the project pipeline.

## Performance profiles

`sandbox`, `development` and `production` select predefined configurations (see `locals` in `main.tf`).

## Inputs

| Name | Description |
|------|-------------|
| `service_name` | The name of the service. Used for DynamoDB table naming. 3-255 characters: letters, numbers, hyphens, underscores and dots. |
| `performance_profile` | The performance tier selected by the developer (sandbox, development, production). Point-in-time recovery and deletion protection are automatically configured based on this profile. |
| `partition_key` | The name of the partition (hash) key attribute. Stored as a string. |
| `additional_tags` | Additional tags to apply, as a JSON object (e.g. {"team": "backend"}). |

## Outputs

| Name | Description |
|------|-------------|
| `table_name` | The name of the DynamoDB table. |
| `table_arn` | The ARN of the DynamoDB table. |

## Requirements

Terraform >= 1.0, AWS provider ~> 5.0. Credentials and region come from the environment (`AWS_*` variables).
