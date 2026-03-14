# Terraform State Locking — S3 + DynamoDB

## What this does

Creates the AWS infrastructure needed for safe, shared Terraform state:

| Resource | Purpose |
|---|---|
| S3 bucket | Stores the `terraform.tfstate` file, versioned + encrypted |
| DynamoDB table | Issues a `LockID` so only one `terraform apply` runs at a time |

## Files

```
.
├── provider.tf       # AWS provider + version constraints
├── main.tf           # S3 bucket + DynamoDB table resources
├── variables.tf      # Input variables
├── outputs.tf        # Bucket name, table name, ready-to-paste backend block
├── terraform.tfvars  # Your values (edit before running)
└── backend.tf        # Paste into your project after bootstrap
```

## Usage

### Step 1 — Bootstrap (run once)

```bash
cd terraform-state-locking/
terraform init        # uses local state on first run
terraform apply
```

This creates the S3 bucket and DynamoDB table. The outputs include a ready-to-paste `backend "s3"` block.

### Step 2 — Migrate state to S3 (optional but recommended)

After the bucket exists you can store this module's own state in it:

```bash
# Copy the backend block from outputs, paste into backend.tf, then:
terraform init -migrate-state
```

### Step 3 — Use in your other projects

In each project that needs shared state, create a `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-state-prod"
    key            = "projects/my-service/terraform.tfstate"  # unique per project
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}
```

Then run `terraform init` in that project. Terraform will automatically acquire and release the DynamoDB lock on every `plan` and `apply`.

## Explicit locking in CI/CD

`-lock=true` is Terraform's default when a locking-capable backend is configured, so you don't need to pass it in normal usage. In CI/CD pipelines it's good practice to be explicit and also set a timeout so concurrent jobs wait rather than immediately fail:

```bash
terraform plan  -lock=true -lock-timeout=60s
terraform apply -lock=true -lock-timeout=60s
```

To deliberately skip locking (e.g. for a read-only audit run):

```bash
terraform plan -lock=false
```

## How locking works

1. Engineer 1 runs `terraform apply` → Terraform writes a record to DynamoDB with `LockID = <path>`
2. Engineer 2 runs `terraform apply` → DynamoDB rejects the write (key already exists) → Terraform prints `Error: state locked` and exits
3. Engineer 1's apply completes → lock record is deleted
4. Engineer 2 retries → lock acquired, apply proceeds safely

## Requirements

- Terraform >= 1.5.0
- AWS credentials with permissions for S3 and DynamoDB
- A globally unique S3 bucket name (set in `terraform.tfvars`)
