resource "aws_instance" "dev" {
  provider = aws.devenv
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "dev-instance"
    }
}


## ============================================================
## VPC in West-2 Oregeon
## ============================================================
resource "aws_vpc" "test-vpc" {
  provider = aws.testenv
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.env}-vpc"
  }
}


## ============================================================
## PUBLIC SUBNETS
## ============================================================
resource "aws_subnet" "public_subnet_2a" {
  provider = aws.testenv
  vpc_id            = aws_vpc.test-vpc.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.availability_zone_2a
  tags = {
    Name = "${var.env}-public-subnet-1"
  }

}
## ============================================================
## EC2 in PUBLIC SUBNET
## ============================================================


resource "aws_instance" "test" {
    ami = var.test_ami_id
    instance_type = var.test_instance_type
    provider = aws.testenv
######Please replace subnet id from us-west-2a
     subnet_id = "subnet-002bc87999bd986b7" ## must replace for it to work

######Please replace SG -Security id from us-west-2a

  vpc_security_group_ids = [
    "sg-0522b764561150816"  ### must replace for it to work
  ]
    tags = {
        Name = "test-instance"
    }
}

