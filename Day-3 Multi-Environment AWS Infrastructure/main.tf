# ============================================================
# DEV ENVIRONMENT  (us-east-1)
# ============================================================

resource "aws_instance" "dev" {
  provider      = aws.devenv
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "dev-instance"
  }
}

# ============================================================
# TEST ENVIRONMENT  (us-west-2)
# ============================================================

# --- VPC ---

resource "aws_vpc" "test_vpc" {
  provider   = aws.testenv
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

# --- Public Subnet (us-west-2a) ---

resource "aws_subnet" "public_subnet_2a" {
  provider          = aws.testenv
  vpc_id            = aws_vpc.test_vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.availability_zone_2a

  tags = {
    Name = "${var.env}-public-subnet-1"
  }
}

# --- Security Group ---
# Allows inbound SSH (22) and HTTP (80) from anywhere.
# All outbound traffic is permitted.

resource "aws_security_group" "test_sg" {
  provider    = aws.testenv
  name        = "${var.env}-sg"
  description = "Security group for the test environment"
  vpc_id      = aws_vpc.test_vpc.id

  # Allow SSH from anywhere (tighten to your IP in production)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP from anywhere
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg"
  }
}

# --- EC2 Instance in Public Subnet ---

resource "aws_instance" "test" {
  provider               = aws.testenv
  ami                    = var.test_ami_id
  instance_type          = var.test_instance_type
  subnet_id              = aws_subnet.public_subnet_2a.id
  vpc_security_group_ids = [aws_security_group.test_sg.id]

  tags = {
    Name = "test-instance"
  }
}
