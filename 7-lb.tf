resource "aws_lb" "lb" {
  load_balancer_type = "application"

  internal = false
  enable_cross_zone_load_balancing = true
  subnets = aws_subnet.public_subnets.*.id
  ip_address_type = "ipv4"

  security_groups = [ aws_security_group.lb.id ]
}

resource "aws_lb_target_group" "lb_target_group" {
  port = 6443
  protocol = "HTTP"
  target_type = "ip"
  ip_address_type = "ipv4"

  vpc_id = aws_vpc.vpc.id
  load_balancing_cross_zone_enabled = true
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn

  port = "6443"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_initial_master_node_attachment" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = aws_instance.master_nodes[0].private_ip

  depends_on = [ aws_lb_listener.lb_listener ]
}