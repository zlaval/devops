data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_lb_target_group" "target-group" {
  name     = "${var.namespace}-${var.project_name}-tg"
  protocol = "HTTP"
  vpc_id   = var.vpc.id
  port     = 8080
  health_check {
    enabled           = true
    path              = "/"
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.alb.lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}

resource "aws_security_group" "instance" {
  name        = "${var.namespace}-${var.project_name}-app"
  description = "Allow traffic to application"
  vpc_id      = var.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    security_groups = [var.alb.sg.id]
    self            = false
  }
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

data "cloudinit_config" "httpserver" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/cloud_config.yaml", var.db_config )
  }
}

resource "aws_key_pair" "ssh" {
  public_key = var.ssh_key
  key_name   = "ssh"
}

resource "aws_launch_template" "server" {
  name_prefix            = "${var.namespace}-${var.project_name}"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.ssh.key_name
  user_data              = data.cloudinit_config.httpserver.rendered
  vpc_security_group_ids = [aws_security_group.instance.id]
}

resource "aws_autoscaling_group" "server" {
  name                = "${var.namespace}-${var.project_name}-asg"
  max_size            = 2
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [var.subnet.public_a.id, var.subnet.public_b.id]
  target_group_arns   = [aws_lb_target_group.target-group.arn]
  launch_template {
    id      = aws_launch_template.server.id
    version = aws_launch_template.server.latest_version
  }

  lifecycle {
    ignore_changes = [desired_capacity]
  }
}

resource "aws_autoscaling_policy" "scaling_up" {
  name                   = "${var.namespace}-${var.project_name}-scale_up"
  autoscaling_group_name = aws_autoscaling_group.server.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 30
  scaling_adjustment     = 1
}

resource "aws_autoscaling_policy" "scaling_down" {
  name                   = "${var.namespace}-${var.project_name}-scale_down"
  autoscaling_group_name = aws_autoscaling_group.server.name
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 30
  scaling_adjustment     = -1
}

resource "aws_cloudwatch_metric_alarm" "scale" {
  alarm_name          = "${var.namespace}-${var.project_name}-scale"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  period              = 60
  metric_name         = "CPUUtilization"
  threshold           = 80
  statistic           = "Average"
  alarm_actions       = [aws_autoscaling_policy.scaling_up.arn]
  ok_actions          = [aws_autoscaling_policy.scaling_down.arn]
  namespace           = "AWS/EC2"
  dimensions          = {
    AutoScalingGroupName = aws_autoscaling_group.server.name
  }
}