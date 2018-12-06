resource "aws_security_group" "int" {
  name = "${var.env}-${var.identifier}-int-elb"
  vpc_id = "${var.vpc-id}"
  description = "${var.env}-${var.identifier}-int-elb"

  tags {
    Name = "${var.env}-${var.identifier}-int-elb"
  }
}

resource "aws_security_group_rule" "int_egress_all" {
  security_group_id = "${aws_security_group.int.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [ "0.0.0.0/0" ]
}

/* http is necessary for ECS containers connecting back to
 * ${var.name}.${var.dns-internal-name}/tcpSlaveListener!
 */
resource "aws_security_group_rule" "int_ingress_http" {
  security_group_id = "${aws_security_group.int.id}"
  type = "ingress"
  from_port = "${var.ports["http"]}"
  to_port = "${var.ports["http"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

/* https is used for external access to the Jenkins container
 */
resource "aws_security_group_rule" "int_ingress_https" {
  security_group_id = "${aws_security_group.int.id}"
  type = "ingress"
  from_port = "${var.ports["https"]}"
  to_port = "${var.ports["https"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

resource "aws_security_group_rule" "int_ingress_jnlp" {
  security_group_id = "${aws_security_group.int.id}"
  type = "ingress"
  from_port = "${var.ports["jnlp"]}"
  to_port = "${var.ports["jnlp"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

