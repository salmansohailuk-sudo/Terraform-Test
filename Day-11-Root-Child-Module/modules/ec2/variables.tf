variable "ami_id" {}
variable "instance_type" {}
variable "subnet_1_id" {}
variable "sg_id" {
  description = "Security group ID to attach to the EC2 instance"
  type        = string
}