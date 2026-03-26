# -----------------------------------------------
# Security Group Module - variables.tf
# -----------------------------------------------

variable "vpc_id" {
  description = "The VPC ID where security groups will be created"
  type        = string
}

variable "ec2_sg_name" {
  description = "Name for the EC2 security group"
  type        = string
  default     = "ec2-sg"
}

variable "rds_sg_name" {
  description = "Name for the RDS security group"
  type        = string
  default     = "rds-sg"
}