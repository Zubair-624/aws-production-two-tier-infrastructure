variable "project_name" {
    description = "Name of the project used in all resource names and tags"
    type = string 
}

variable "environment" {
    description = "Deployment environment (dev or prod)"
    type = string

    validation {
      condition = contains(["dev", "prod"], var.environment)
      error_message = "Environment must be either 'dev' or 'prod'"
    }
}

variable "vpc_id" {
    description = "ID of the VPC passed from networking module"
    type = string
}

variable "public_subnet_ids" {
    description = "IDs of public subnets ALB lives here"
    type = list(string)
}

variable "alb_sg_id" {
    description = "Security group ID for the ALB"
    type = string
}

variable "aws_account_id" {
    description = "Your AWS account ID needed for ALB log bucket policy"
    type = string
    sensitive = true
}

variable "enable_deletion_protection" {
    description = "Enable deletion protection on ALB"
    type = bool
    default = true
}

