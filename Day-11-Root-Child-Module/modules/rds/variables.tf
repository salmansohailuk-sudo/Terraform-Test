variable "subnet_1_id" {}
variable "subnet_2_id" {}
variable "instance_class" {}
variable "db_name" {}
variable "db_user" {}
variable "db_password" {}
variable "sg_id" {
  description = "Security group ID to attach to the RDS instance"
  type        = string
}