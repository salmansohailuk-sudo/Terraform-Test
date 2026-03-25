data "aws_subnet" "name" {
  filter {
    name   = "tag:Name"
    values = ["hr-subnet-1"]
  }
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "name" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.name.id

  tags = {
    Name = "hr-ec2-instance"
  }
}