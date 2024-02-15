data "aws_route53_zone" "my_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "name" {
  depends_on = [data.aws_route53_zone.my_zone]
  zone_id    = data.aws_route53_zone.my_zone.zone_id
  name       = var.subdomain_name
  type       = "A"
  alias {
    name                   = aws_lb.my-load-balancer.dns_name
    zone_id                = aws_lb.my-load-balancer.zone_id
    evaluate_target_health = false
  }
}

