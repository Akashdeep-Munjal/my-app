resource "aws_security_group" "ec2_sg" {
    vpc_id = var.vpc_id
    name   = "${var.ec2_instance_name}-sg"
    tags = {
      Name = "${var.ec2_instance_name}-sg"
      terraform   = "true"
      env = var.env
      costcenter = var.costcenter
    }
}
resource "aws_security_group_rule" "ec2_sg_in" {
    type              = "ingress"
    from_port         = 8080
    protocol          = "tcp"
    to_port           = 8080
    source_security_group_id = var.elb_sg
    security_group_id = aws_security_group.ec2_sg.id
}
resource "aws_security_group_rule" "ec2_sg_out" {
    type              = "egress"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.ec2_sg.id
}