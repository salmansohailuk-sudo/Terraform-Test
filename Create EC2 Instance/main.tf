resource "aws_instance" "Bastion-Server" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "dev-instance"
    }
}