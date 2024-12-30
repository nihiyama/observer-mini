resource "aws_security_group" "sg" {
  name   = "${var.basename}-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.basename}-sg"
  }
}

resource "aws_security_group_rule" "ingress_internal" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg.id
  security_group_id        = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_management" {
  for_each          = var.ingress_management_ports
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = var.ingress_management_cidr_blocks
  security_group_id = aws_security_group.sg.id
  description       = "to ${each.key}"
}

resource "aws_security_group_rule" "ingress_service" {
  for_each          = var.ingress_service_ports
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = var.ingress_service_cidr_blocks
  security_group_id = aws_security_group.sg.id
  description       = "to ${each.key}"
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}
