resource "aws_vpc" "name" {
    provider = aws.uatenv
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "uat"
    }
  
}

resource "aws_instance" "name" {
    provider = aws.uatenv
    ami = "ami-02dfbd4ff395f2a1b"
    #ami = "ami-03caad32a158f72db"
    instance_type = "t2.medium"
    tags = {
        Name = "uat-instance"
    }   
  
}