output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "rds_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.rds.arn
}

output "rds_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.rds.id
}

output "rds_pass" {
  description = "passwords for rds"
  value = data.aws_secretsmanager_secret.db_password.arn
  sensitive = true
  
}