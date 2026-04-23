output "alb_arn" {
    description = "ARN of the Application Load Balancer"
    value = aws_lb.main.arn
}

output "alb_dns_name" {
    description = "DNS name of the ALB — use this to access the application"
    value = aws_lb.main.dns_name
}

output "target_group_arn" {
    description = "ARN of the target group passed to Auto Scaling Group"
    value = aws_lb_target_group.main.arn
}

output "alb_zone_id" {
    description = "Hosted zone ID of the ALB used for Route53 alias records"
    value = aws_lb.main.zone_id
}

output "alb_logs_bucket" {
    description = "Name of the S3 bucket storing ALB access logs"
    value = aws_s3_bucket.alb_logs.bucket
}