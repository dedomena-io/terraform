resource "aws_route53_zone" "main" {
   name = "krolm.com"
}

resource "aws_route53_zone" "dev" {
  name  = "dev.krolm.com"

  vpc {
    vpc_id = aws_vpc.dev.id
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-krolm" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.krolm.com"
  type    = "NS"
  ttl     = "30"

  records = [
    "${aws_route53_zone.dev.name_servers.0}",
    "${aws_route53_zone.dev.name_servers.1}",
    "${aws_route53_zone.dev.name_servers.2}",
    "${aws_route53_zone.dev.name_servers.3}",
  ]
}

# Public www records
#resource "aws_route53_record" "apex" {
#  zone_id = aws_route53_zone.main.zone_id
#  name = "krolm.com"
#  type = "A"
#  alias {
#    name = "www.krolm.com"
#    zone_id = aws_route53_zone.main.zone_id
#    evaluate_target_health = false
#  }
#  depends_on = [
#    aws_route53_zone.main
#  ]
#}
