
## dev environment variables##
#here dev = defualt profile in provider.tf
variable "ami_id" {
    description = "passing values to ami_id"
    default = ""
    type = string
  
}
variable "instance_type" {
    description = "passing values to instance_type"
    default = ""
    type = string
  
}

### test env variables## 
variable "test_ami_id" {
    description = "passing values to ami_id"
    default = ""
    type = string
  
}
variable "test_instance_type" {
    description = "passing values to instance_type"
    default = ""
    type = string
  
}

## ============================================================
## NETWORKING — CIDRs
## ============================================================
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "CIDR for public subnet in AZ 1a"
  type        = string
  default     = "10.0.1.0/24"
}

## ============================================================
## Environment — Variable
## ============================================================

variable "env" {
  description = "Environment name (e.g. dev, staging, prod)"
  type        = string
  default     = "test"
}

## ============================================================
## AVAILABILITY ZONES
## ============================================================
variable "availability_zone_2a" {
  description = "Primary availability zone"
  type        = string
  default     = "us-west-2a"
}