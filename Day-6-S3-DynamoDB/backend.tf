# =============================================================
# backend.tf  — place this in YOUR PROJECT (not the bootstrap module)
#
# After running the bootstrap module, copy the bucket name and
# table name from its outputs and paste them here.
# =============================================================

terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-state-prod"   # from bootstrap output
    key            = "global/terraform.tfstate"         # unique path per project/env
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"            # from bootstrap output
    encrypt        = true
  }
}

# -lock=true is the default when a locking-capable backend (e.g. S3+DynamoDB) is
# configured, but you can make it explicit in your CI/CD pipeline commands:
#
#   terraform plan  -lock=true -lock-timeout=60s
#   terraform apply -lock=true -lock-timeout=60s
#
# -lock-timeout tells Terraform to retry acquiring the lock for up to N seconds
# before giving up, which is useful when pipelines run concurrently.
