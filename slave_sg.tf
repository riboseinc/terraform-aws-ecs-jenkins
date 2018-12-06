resource "aws_security_group" "ec2-slave" {
  name = "${var.env}-${var.identifier}-ec2-slave-sg"
  vpc_id = "${var.vpc-id}"
  description = "${var.env}-${var.identifier}-ec2-slave-sg"

  tags {
    Name = "${var.env}-${var.identifier}-ec2-slave-sg"
  }
}

/* accept ingress connections from ECS node
 */
resource "aws_security_group_rule" "ec2-slave-ingress-jenkins-ssh" {
  security_group_id = "${aws_security_group.ec2-slave.id}"
  type = "ingress"
  from_port = "${var.ports["ssh"]}"
  to_port = "${var.ports["ssh"]}"
  protocol = "tcp"
  source_security_group_id = "${var.sg-id}"
}

resource "aws_security_group_rule" "ec2-slave-egress-all" {
  security_group_id = "${aws_security_group.ec2-slave.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = [ "0.0.0.0/0" ]
}

