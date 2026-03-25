resource "aws_db_subnet_group" "hrdb-subnet-group" {
  name       = "hrdb-subnet-group"
  subnet_ids = [var.subnet_1_id, var.subnet_2_id]
  

  tags = {
    Name = "HR DB Subnet Group"
  }
}

resource "aws_db_instance" "mysql-hrdb" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.hrdb-subnet-group.name
  skip_final_snapshot  = true
}