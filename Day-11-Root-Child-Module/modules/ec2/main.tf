resource "aws_instance" "haanifaisl_app1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_1_id

  tags = {
    Name = "App1Server"
  }
}