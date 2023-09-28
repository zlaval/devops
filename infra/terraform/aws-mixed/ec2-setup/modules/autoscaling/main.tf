data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

resource "aws_lb" "load_balancer" {
  name = "load_balancer"
  load_balancer_type = "application"
  subnets = [
    var.subnet.public.id
  ]
  security_groups = [var.security_group.load_balancer]
}

resource "aws_lb_target_group" "target_group" {
  name = "target_group"
  protocol = "HTTP"
  vpc_id = var.vpc.id
  target_type = "ip"
  port = 8080
#  health_check {
#    path = ""
#  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_launch_template" "server" {
  name_prefix            = var.namespace
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
# key_name               = var.ssh_keypair
  vpc_security_group_ids = [var.security_group.application]
}

resource "aws_autoscaling_group" "server" {
  name                = "${var.namespace}-${var.project_name}-asg"
  max_size            = 1
  min_size            = 1
  desired_capacity    = 1
  vpc_zone_identifier = [var.subnet.public.id]
  target_group_arns   = module.alb.target_group_arns
  launch_template {
    id      = aws_launch_template.server.id
    version = aws_launch_template.server.latest_version
  }
}
