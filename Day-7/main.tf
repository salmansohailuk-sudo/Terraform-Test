#Create of VPC, subnet, IG, RT, an dSecurty group

resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod-vpc"

    }
}

resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
        Name = "public-subnet1"
    }
}

resource "aws_subnet" "prod" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2a"
    tags = {
        Name = "public-subnet2"
    }
}


resource "aws_internet_gateway" "prod-ig" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "ig-prod"
    }
}

resource "aws_route_table" "public-rt " {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_interget_gateway.prod-ig.id
    }
    tags = {
        Name = "public-rt"
    }

}

resource "aws_subnet_association" "prod" {

    subnet_id = aws_subnet.public-rt.id {
        
    }
}
