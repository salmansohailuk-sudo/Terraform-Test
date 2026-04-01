resource "aws_db_instance" "primary" {
  identifier              = var.primary_identifier
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  skip_final_snapshot     = true
  publicly_accessible     = var.publicly_accessible
}

resource "aws_db_instance" "replica" {
  identifier              = var.replica_identifier
  replicate_source_db     = aws_db_instance.primary.identifier
  instance_class          = var.instance_class
  publicly_accessible     = var.publicly_accessible
}


