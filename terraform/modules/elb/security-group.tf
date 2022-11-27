resource "aws_security_group" "elb_sg" {
  name        = "${var.elb_name}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id


  tags = {
    Name = "${var.elb_name}-sg"
    terraform = "true"
    env = var.env
    costcenter = var.costcenter
  }
}

resource "aws_security_group_rule" "http_port" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}
resource "aws_security_group_rule" "https_port" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}
resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elb_sg.id
}