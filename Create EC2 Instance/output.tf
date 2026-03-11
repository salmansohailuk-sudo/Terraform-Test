output "public_ip" {
    value = aws_instance.Bastion-Server.public_ip
  
}
output "privatip" {
    value = aws_instance.Bastion-Server.private_ip
  
}
output "az" {
    value = aws_instance.Bastion-Server.availability_zone
  
}