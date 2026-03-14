# =============================================================
# variables.tf
# =============================================================

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state"
  type        = string
  # Example: "mycompany-terraform-state-prod"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "terraform-state-locks"
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Purpose     = "TerraformStateLocking"
  }
}
