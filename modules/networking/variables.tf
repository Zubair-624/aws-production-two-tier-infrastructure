variable "project_name" {
    description = "Name of the project - used in all resource names and tags"
    type = string
}

variable "environment" {
    description = "Deployment environment (dev or prod)"
    type = string

    validation {
      condition = contains(["dev", "prod"], var.environment)
      error_message = "Environment must be either 'dev' or 'prod"
    }
}

variable "vpc_cidr" {
    description = "CIDR block for the vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
    description = "CIDR blocks for the 2 public subnets"
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "private_subnet_cidrs" {
    description = "CIDR blocks for the 2 private subnets"
    type = list(string)
    default = [ "10.0.3.0/24", "10.0.4.0/24" ]
}

variable "availability_zones" {
    description = "Availability zones to deploy subnets into"
    type = list(string)
    default = [ "us-east-1a", "us-east-1b" ]
}