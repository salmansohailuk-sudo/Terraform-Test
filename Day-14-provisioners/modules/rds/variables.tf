variable "primary_identifier" {
  type        = string
  description = "Name of the primary RDS instance"
}

variable "replica_identifier" {
  type        = string
  description = "Name of the read replica"
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "engine" {
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  type        = string
}

variable "username" {
  type        = string
}

variable "password" {
  type        = string
  sensitive   = true
}

variable "publicly_accessible" {
  type        = bool
  default     = true
}
