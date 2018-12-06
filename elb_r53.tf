
# this record is for the internal ELB
resource "aws_route53_record" "elb" {
  zone_id = "${var.r53-public-zone-id}"
  name    = "elb.${var.r53-public-zone-name}"
  type    = "CNAME"
  ttl     = "5"

  weighted_routing_policy {
    weight = 10
  }

  set_identifier = "live"
  records = [ "${aws_elb.int.dns_name}" ]
}
