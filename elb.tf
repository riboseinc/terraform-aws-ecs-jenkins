# TODO: Unable to use ALB because we forward multiple ports to multiple
# ports

resource "aws_elb" "int" {
  name = "${var.env}-${var.identifier}-int-elb"
  subnets = [ "${var.subnet-primary-id}" ]
  security_groups = [ "${aws_security_group.int.id}" ]
  cross_zone_load_balancing = false
  idle_timeout = 900
  internal = true
  connection_draining = false
  connection_draining_timeout = 300

  listener {
    instance_port = "${var.ports["docker"]}"
    instance_protocol = "http"
    lb_port = "${var.ports["docker"]}"
    lb_protocol = "http"
  }

  listener {
    instance_port = "${var.ports["jenkins_http"]}"
    instance_protocol = "http"
    lb_port = "${var.ports["http"]}"
    lb_protocol = "http"
  }

  listener {
    instance_port = "${var.ports["jnlp"]}"
    instance_protocol  = "tcp"
    lb_port = "${var.ports["jnlp"]}"
    lb_protocol = "tcp"
  }

  listener {
    instance_port = "${var.ports["jenkins_http"]}"
    instance_protocol = "http"
    lb_port = "${var.ports["https"]}"
    lb_protocol = "https"
    ssl_certificate_id = "${var.iam-certificate-arn}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 5
    interval = 60
    target = "HTTP:${var.ports["docker"]}/containers/json"
    timeout = 15
  }

  tags {
    DEPLOYMENT = "${var.env}-${var.identifier}"
  }

}

