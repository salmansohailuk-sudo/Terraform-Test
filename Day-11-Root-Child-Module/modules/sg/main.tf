# -----------------------------------------------
# Security Group Module - main.tf
# -----------------------------------------------

# EC2 Security Group - allows SSH (22) and HTTP (80) inbound
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg_name
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ec2_sg_name
  }
}

# RDS Security Group - allows MySQL (3306) only from EC2 SG
resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Security group for RDS instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL from EC2 SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.rds_sg_name
  }
}