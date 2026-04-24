output "db_endpoint" {
  description = "RDS endpoint hostname — EC2 connects here"
  value       = aws_db_instance.main.address
}

output "db_port" {
  description = "RDS port number (3306 for MySQL)"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Name of the MySQL database"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "Master username for RDS"
  value       = aws_db_instance.main.username
}

output "db_secret_name" {
  description = "Secrets Manager secret name storing the DB password"
  value       = aws_secretsmanager_secret.db_password.name
}

output "db_secret_arn" {
  description = "ARN of Secrets Manager secret — used in EC2 IAM policy"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "db_instance_id" {
  description = "RDS instance identifier"
  value       = aws_db_instance.main.identifier
}

output "db_instance_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.main.arn
}

output "db_multi_az" {
  description = "Whether Multi-AZ is enabled on this RDS instance"
  value       = aws_db_instance.main.multi_az
}