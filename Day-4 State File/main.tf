resource "aws_vpc" "Dev-VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev-VPC"
  } 

}