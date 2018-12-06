resource "aws_route53_record" "private-A" {
  zone_id = "${var.r53-internal-zone-id}"
  name = "${var.name}.${var.r53-internal-zone-name}"
  type = "A"

  alias {
    name = "${aws_elb.int.dns_name}"
    zone_id = "${aws_elb.int.zone_id}"
    evaluate_target_health = false
  }
}
