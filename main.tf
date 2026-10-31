resource "aws_security_group" "this" {
  name_prefix = "novasphere-${var.environment}-web-"
  description = "HTTP depuis ALB seulement"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP depuis ALB seulement"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "this" {
  name_prefix   = "novasphere-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.this.id]
  user_data              = base64encode(var.user_data)

  iam_instance_profile {
    name = var.instance_profile_name
  }

  metadata_options {
    http_tokens = "required"
  }

  tag_specifications {
    resource_type = "instance"
    tags          = { Name = "novasphere-${var.environment}-web" }
  }
}

resource "aws_autoscaling_group" "this" {
  name                = "novasphere-${var.environment}-web"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = [var.target_group_arn]
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  tag {
    key                 = "Name"
    value               = "novasphere-${var.environment}-web"
    propagate_at_launch = true
  }
}
