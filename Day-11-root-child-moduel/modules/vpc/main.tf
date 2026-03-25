#resource "aws_vpc" "hr-vpc" {
#  cidr_block = var.cidr_block
#}

#resource "aws_subnet" "hr-subnet-1" {
#  vpc_id     = aws_vpc.hr-vpc.id
#  cidr_block = var.subnet_1_cidr
#  availability_zone = var.az1
#}

#resource "aws_subnet" "hr-subnet-2" {
#    vpc_id = aws_vpc.hr-vpc.id
#    cidr_block = var.subnet_2_cidr
#    availability_zone = var.az2

  
#}


#output "subnet_1_id" {
#  value = "${aws_subnet.hr-subnet-1.id}"
#}

#output "subnet_2_id" {
#  value = "${aws_subnet.hr-subnet-2.id}"
#}



resource "aws_vpc" "hr-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name     = var.vpc_name
    #tag_name = var.vpc_name
  }
}

resource "aws_subnet" "hr-subnet-1" {
  vpc_id            = aws_vpc.hr-vpc.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = var.az1

  tags = {
    Name     = var.subnet_1_name
   # tag_name = var.subnet_1_name
  }
}

resource "aws_subnet" "hr-subnet-2" {
  vpc_id            = aws_vpc.hr-vpc.id
  cidr_block        = var.subnet_2_cidr
  availability_zone = var.az2

  tags = {
    Name     = var.subnet_2_name
    #tag_name = var.subnet_2_name
  }
}


output "subnet_1_id" {
  value = aws_subnet.hr-subnet-1.id
}

output "subnet_2_id" {
  value = aws_subnet.hr-subnet-2.id
}
