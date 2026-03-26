variable "db_name" {}
variable "username" {}
variable "password" {}
variable "instance_class" {}
variable "engine" {}
variable "engine_version" {}

resource "aws_db_instance" "primary" {
  identifier              = "primary-db"
  allocated_storage       = 20
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  skip_final_snapshot     = true
  publicly_accessible     = true
}

resource "aws_db_instance" "replica" {
  identifier              = "read-replica"
  replicate_source_db     = aws_db_instance.primary.identifier
  instance_class          = var.instance_class
  publicly_accessible     = true
}

output "primary_endpoint" {
  value = aws_db_instance.primary.address
}


