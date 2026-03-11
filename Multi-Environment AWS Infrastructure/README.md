# 🏗️ Terraform Multi-Environment AWS Infrastructure

> 👨‍💻 **Salman Sayeed, MSc — DevOps Engineer** · Built from scratch
> 📱 WhatsApp: +447356261995 · 📧 salmansohailuk@gmail.com

---

> Manage **dev** and **test** AWS environments from a single codebase — clean, simple, no hardcoded values.

---

## 📁 Project Structure

```
.
├── main.tf          # All AWS resources (EC2, VPC, Subnet, Security Group)
├── provider.tf      # AWS provider config for dev + test
├── variables.tf     # All variable declarations
├── dev.tfvars       # Dev environment values  (us-east-1)
└── test.tfvars      # Test environment values (us-west-2)
```

---

## 🔑 AWS IAM Setup — Test Environment (us-west-2)

Before Terraform can provision resources in the test account, you need an IAM user with programmatic access.

### Step 1 — Create the IAM User

1. Sign in to the **AWS Console** and navigate to **IAM → Users → Create user**
2. Enter a username (e.g. `terraform-test`)
3. Check **✅ Provide user access to the AWS Management Console**
4. Select **I want to create an IAM user**
5. Choose **Custom password** and set a strong password
6. Uncheck "User must create a new password at next sign-in" (optional for automation)
7. Click **Next**

### Step 2 — Attach Permissions

1. On the **Set permissions** page, choose **Attach policies directly**
2. Search for and select **AdministratorAccess**
3. Click **Next → Create user**

> ⚠️ **Note:** `AdministratorAccess` is suitable for a test/learning environment. For production, always use least-privilege policies scoped to only the resources Terraform needs.

### Step 3 — Create an Access Key

1. From **IAM → Users**, click on your newly created user
2. Go to the **Security credentials** tab
3. Scroll down to **Access keys → Create access key**
4. Select **Command Line Interface (CLI)** as the use case
5. Click through and **save both values** — you won't see the secret again:

```
Access Key ID:     AKIA47CRWHENPGPRPORG        ← example, replace with yours
Secret Access Key: 8AB5TzQdz8ya4XHNRw3Dd+...  ← example, replace with yours
```

> 🔐 **Never commit these keys to Git.** Store them only in `~/.aws/credentials`.

### Step 4 — Configure the AWS CLI Profile

Run the following and paste in the keys from Step 3:

```bash
aws configure --profile test

```

```
AWS Access Key ID:     <your-access-key-id>
AWS Secret Access Key: <your-secret-access-key>
Default region name:   us-west-2
Default output format: json
```

Verify it works:

```bash
aws sts get-caller-identity --profile test
```

You should see your account ID and user ARN returned. ✅

---

## ⚙️ Prerequisites

Before you begin, make sure you have:

- [ ] [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.0` installed
- [ ] [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) installed and configured
- [ ] Two AWS CLI named profiles set up:

```bash

### 1. Show configured AWS profiles from GIT Bash
####  aws configure list-profiles
####  aws configure list --profile dev
####  aws configure list --profile test

### 2. Display credentials file (contains access keys)
#### cat ~/.aws/credentials

# Check your profiles exist

| Profile | Environment | Region    |
|---------|-------------|-----------|
| `dev`   | Development | us-east-1 |
| `test`  | Test        | us-west-2 |

---

## 🚀 Quick Start

### 1 — Clone & enter the project

```bash
git clone https://github.com/salmansohailuk-sudo/Terraform-Test.git
cd <project-folder>
```

### 2 — Initialize Terraform

```bash
terraform init
```

> Downloads the AWS provider plugin. Run this once, or again after adding new providers.

---

## 🌍 Deploying an Environment

### Deploy **Dev and Test** (us-east-1/us-west-2)
### Preview changes
terraform plan

### Apply changes
terraform apply

## OR Plan and Deploy Individual Environment 

### Deploy **Dev** (us-east-1)

```bash
# Preview changes
terraform plan -var-file="dev.tfvars"

# Apply changes
terraform apply -var-file="dev.tfvars"
```

### Deploy **Test** (us-west-2)

```bash
# Preview changes
terraform plan -var-file="test.tfvars"

# Apply changes
terraform apply -var-file="test.tfvars"
```

> 💡 Always run `plan` before `apply` to review what will be created or changed.

---

## 🧱 What Gets Created

### Dev Environment (`aws.devenv` → us-east-1)

| Resource     | Details                  |
|--------------|--------------------------|
| EC2 Instance | `dev-instance` — t2.medium |

---

### Test Environment (`aws.testenv` → us-west-2)

| Resource        | Details                                  |
|-----------------|------------------------------------------|
| VPC             | `test-vpc` — `10.0.0.0/16`              |
| Public Subnet   | `test-public-subnet-1` — `10.0.1.0/24` (us-west-2a) |
| Security Group  | `test-sg` — SSH (22) + HTTP (80) inbound |
| EC2 Instance    | `test-instance` — t2.micro, placed in the subnet above |

---

## 🔒 Security Group Rules (Test Environment)

| Direction | Port | Protocol | Source      | Purpose        |
|-----------|------|----------|-------------|----------------|
| Inbound   | 22   | TCP      | `0.0.0.0/0` | SSH access     |
| Inbound   | 80   | TCP      | `0.0.0.0/0` | HTTP traffic   |
| Outbound  | All  | All      | `0.0.0.0/0` | All traffic out |

> ⚠️ **Security tip:** For production or shared environments, replace `0.0.0.0/0` on port 22 with your specific IP address to restrict SSH access:
> ```hcl
> cidr_blocks = ["YOUR.IP.ADDRESS/32"]
> ```

---

## 🗑️ Tearing Down Resources

```bash
# Destroy dev resources
terraform destroy -var-file="dev.tfvars"

# Destroy test resources
terraform destroy -var-file="test.tfvars"
```

> ⚠️ This permanently deletes all resources in that environment. Double-check before confirming.

---

## ✏️ Customising Variables

Edit the relevant `.tfvars` file to change any values:

**`dev.tfvars`**
```hcl
ami_id        = "ami-xxxxxxxxxxxxxxxxx"   # Your dev AMI
instance_type = "t2.medium"
```

**`test.tfvars`**
```hcl
test_ami_id          = "ami-xxxxxxxxxxxxxxxxx"   # Your test AMI
test_instance_type   = "t2.micro"
env                  = "test"
vpc_cidr             = "10.0.0.0/16"
public_subnet1_cidr  = "10.0.1.0/24"
availability_zone_2a = "us-west-2a"
```

---

## 🛠️ Common Commands Cheat Sheet

```bash
terraform init                          # Initialise project (run once)
terraform fmt                           # Auto-format all .tf files
terraform validate                      # Check config for errors
terraform plan  -var-file="*.tfvars"    # Preview changes
terraform apply -var-file="*.tfvars"    # Apply changes
terraform destroy -var-file="*.tfvars"  # Remove all resources
terraform show                          # View current state
terraform output                        # Show output values
```

---

## ❓ Troubleshooting

**`Error: No valid credential sources found`**
→ Check your AWS CLI profiles are configured: `aws configure list-profiles`

**`Error: InvalidAMIID`**
→ AMI IDs are region-specific. Make sure the AMI in your `.tfvars` exists in the target region.

**`Error: VPCIdNotSpecified`**
→ The security group and subnet must reference the same VPC. This is already handled in `main.tf` via `aws_vpc.test_vpc.id`.

---

---

## 👨‍💻 Author

**Salman Sayeed, MSc — DevOps Engineer**

Built from scratch ..

| Contact | Details |
|---------|---------|
| 📱 WhatsApp | +447356261995 |
| 📧 Email | salmansohailuk@gmail.com |

---

*Built with Terraform · AWS · ❤️*
