# -----------------------------------------------
# RDS Module - outputs.tf
# -----------------------------------------------

output "rds_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.mysql-hrdb.endpoint
}

output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.mysql-hrdb.id
}