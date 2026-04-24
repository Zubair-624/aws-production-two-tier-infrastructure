variable "project_name" {
  description = "Name of the project — used in all resource names and tags"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev or prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "private_subnet_ids" {
  description = "IDs of private subnets — RDS lives here"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID for RDS — only allows EC2 traffic"
  type        = string
}

variable "db_name" {
  description = "Name of the MySQL database to create"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "admin"
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Initial RDS storage in GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Maximum RDS storage in GB — AWS auto scales up to this"
  type        = number
  default     = 100
}

variable "enable_multi_az" {
  description = "Enable Multi-AZ deployment for RDS high availability"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Number of days to retain automated RDS backups"
  type        = number
  default     = 7
}

variable "enable_deletion_protection" {
  description = "Prevent RDS from being accidentally deleted"
  type        = bool
  default     = true
}

variable "secret_recovery_window" {
  description = "Days before Secrets Manager permanently deletes a secret"
  type        = number
  default     = 7
}

variable "sns_topic_arn" {
  description = "ARN of SNS topic for CloudWatch alarm notifications"
  type        = string
}