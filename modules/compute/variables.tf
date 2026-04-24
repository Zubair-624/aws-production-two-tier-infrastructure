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

variable "aws_region" {
  description = "AWS region where resources are deployed"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID of the VPC — passed from networking module"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets — EC2s launch here"
  type        = list(string)
}

variable "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

# ============================================================
# INSTANCE TYPE — t3.micro runs Ubuntu fine for prod demo
# For real production workloads use t3.small or t3.medium
# ============================================================
variable "instance_type" {
  description = "EC2 instance type — Ubuntu 24.04 LTS compatible"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "Minimum number of EC2 instances in ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of EC2 instances in ASG"
  type        = number
  default     = 4
}

variable "asg_desired_capacity" {
  description = "Desired number of EC2 instances in ASG"
  type        = number
  default     = 2
}

variable "db_endpoint" {
  description = "RDS endpoint — EC2 connects here to reach the database"
  type        = string
}

variable "db_name" {
  description = "Name of the database inside RDS"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_secret_name" {
  description = "Secrets Manager secret name storing the DB password"
  type        = string
}

variable "db_secret_arn" {
  description = "ARN of Secrets Manager secret — used in IAM policy"
  type        = string
}