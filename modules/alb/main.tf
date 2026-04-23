// ALB, target group, listener, health check
resource "aws_lb" "main" {
    name = "${var.project_name}-${var.environment}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.alb_sg_id]
    subnets = var.public_subnet_ids

    enable_deletion_protection = var.enable_deletion_protection

    access_logs {
      bucket = aws_s3_bucket.alb_logs.bucket
      prefix = "${var.project_name}-${var.environment}-alb"
      enabled = true
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-alb"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "terraform"
    }
}

resource "aws_s3_bucket" "alb_logs" {
    bucket = "${var.project_name}-${var.environment}-alb-logs-${var.aws_account_id}"
    force_destroy = true

    tags = {
        Name = "${var.project_name}-${var.environment}-alb-logs"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "terraform"
    } 
}

resource "aws_s3_bucket_lifecycle_configuration" "alb_logs" {
    bucket = aws_s3_bucket.alb_logs.id

    rule {
      id = "delete-old-logs"
      status = "Enabled"
      
      expiration {
        days = 90
      }
    }
}

resource "aws_s3_bucket_policy" "alb_logs" {
    bucket = aws_s3_bucket.alb_logs.id
    policy = data.aws_iam_policy_document.alb_logs.json
}

data "aws_iam_policy_document" "alb_logs" {
    statement {
        effect = "Allow"

        principals {
            type = "AWS"

            identifiers = ["arn:aws:iam::127311923021:root"]
        }

        actions = ["s3:PutObject"]
        resources = ["${aws_s3_bucket.alb_logs.arn}/${var.project_name}-${var.environment}-alb/AWSLogs/${var.aws_account_id}/*"]
    }
}

resource "aws_lb_target_group" "main" {
    name = "${var.project_name}-${var.environment}-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    target_type = "instance"

    health_check {
      enabled = true
      healthy_threshold = 3
      unhealthy_threshold = 3
      timeout = 6
      interval = 30
      path = "/health"
      port = "traffic-port"
      protocol = "HTTP"
      matcher = "200"
    }

    stickiness {
      type = "lb_cookie"
      enabled = false 
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-tg"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "terraform"
    }  
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.main.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.main.arn
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-http-listener"
        Project = var.project_name
        Environment = var.environment
        ManagedBy = "terraform"
    }
}

