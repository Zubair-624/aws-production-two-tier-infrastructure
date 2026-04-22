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

variable "admin_ip" {
    description = "Your admin IP address for SSH access in CIDR format"
    type = string

    validation {
      condition = can(cidrnetmask(var.admin_ip))
      error_message = "admin_ip must be a valid CIDR block like 1.1.1.1/32"
    }
  
}