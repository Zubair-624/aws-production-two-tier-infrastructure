output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.main.arn
}

output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.main.id
}

output "ec2_iam_role_arn" {
  description = "ARN of the IAM role attached to EC2 instances"
  value       = aws_iam_role.ec2.arn
}

output "ubuntu_ami_id" {
  description = "Ubuntu 24.04 LTS AMI ID that was selected"
  value       = data.aws_ami.ubuntu.id
}

output "ubuntu_ami_name" {
  description = "Ubuntu 24.04 LTS AMI name that was selected"
  value       = data.aws_ami.ubuntu.name
}