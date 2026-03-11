# ============================================================
# VARIABLES — DEV ENVIRONMENT  (us-east-1)
# ============================================================

variable "ami_id" {
  description = "AMI ID for the dev EC2 instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "Instance type for the dev EC2 instance"
  type        = string
  default     = ""
}

# ============================================================
# VARIABLES — TEST ENVIRONMENT  (us-west-2)
# ============================================================

variable "test_ami_id" {
  description = "AMI ID for the test EC2 instance"
  type        = string
  default     = ""
}

variable "test_instance_type" {
  description = "Instance type for the test EC2 instance"
  type        = string
  default     = ""
}

variable "env" {
  description = "Environment name used in resource tags (e.g. dev, test)"
  type        = string
  default     = "test"
}

# ============================================================
# VARIABLES — NETWORKING  (test VPC)
# ============================================================

variable "vpc_cidr" {
  description = "CIDR block for the test VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR block for the public subnet in us-west-2a"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone_2a" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "us-west-2a"
}
