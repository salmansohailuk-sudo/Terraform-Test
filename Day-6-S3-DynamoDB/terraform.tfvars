# =============================================================
# terraform.tfvars  — fill in your values before running
# =============================================================

aws_region          = "us-east-1"
bucket_name         = "mycompany-terraform-state-prod"   # must be globally unique
dynamodb_table_name = "terraform-state-locks"

tags = {
  ManagedBy   = "Terraform"
  Purpose     = "TerraformStateLocking"
  Environment = "prod"
}
