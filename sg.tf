resource "aws_security_group_rule" "ecs_ingress_jenkins_http" {
  security_group_id = "${var.sg-id}"
  type = "ingress"
  from_port = "${var.ports["jenkins_http"]}"
  to_port = "${var.ports["jenkins_http"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

resource "aws_security_group_rule" "ecs_ingress_ssh" {
  security_group_id = "${var.sg-id}"
  type = "ingress"
  from_port = "${var.ports["ssh"]}"
  to_port = "${var.ports["ssh"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

resource "aws_security_group_rule" "ecs_ingress_jnlp" {
  security_group_id = "${var.sg-id}"
  type = "ingress"
  from_port = "${var.ports["jnlp"]}"
  to_port = "${var.ports["jnlp"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

resource "aws_security_group_rule" "ecs_ingress_aws_ecs" {
  security_group_id = "${var.sg-id}"
  type = "ingress"
  from_port = "${var.ports["aws_ecs"]}"
  to_port = "${var.ports["aws_ecs"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
  ]
}

resource "aws_security_group_rule" "ecs_ingress_docker" {
  security_group_id = "${var.sg-id}"
  type = "ingress"
  from_port = "${var.ports["docker"]}"
  to_port = "${var.ports["docker"]}"
  protocol = "tcp"
  cidr_blocks = [
    "${var.subnet-primary-cidr}",
    "${var.subnet-secondary-cidr}",
    ]
}

resource "aws_security_group_rule" "ecs_egress_all" {
  security_group_id = "${var.sg-id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [ "0.0.0.0/0" ]
}
