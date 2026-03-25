## 
#Check existing hr-subnet-1 and create hr-project-salman SG with multiple ingress rules for same source 
## Ingress is incoming ports traffic - specific ports and specific sources
## egress outgoing ports traffic 0.0.0.0/0 means all traffic from all sources and to all destinations
## terraform data is used to read existing infrastructure and use it in our terraform code. In this case we are reading existing VPC and attaching SG to it.

data "aws_vpc" "vpc_name" {
  filter {
    name   = "tag:Name"
    values = ["HR_VPC"]
  }
}

resource "aws_security_group" "hr_project_faisal" {
  name        = "hr-project-faisal"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.vpc_name.id   # ✅ Attach SG to existing VPC

  dynamic "ingress" {
    for_each = [22, 80, 443, 8080, 9000, 3000, 8082, 8081]
    content {
      description = "inbound rules"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "hr-project-faisal"
  }
}