resource "aws_route53_zone" "main" {
   name = "dedomena.io"
}

resource "aws_route53_zone" "dev" {
  name  = "dev.dedomena.io"

  vpc {
    vpc_id = aws_vpc.dev.id
  }

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.dedomena.io"
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
#  name = "dedomena.io"
#  type = "A"
#  alias {
#    name = "www.dedomena.io"
#    zone_id = aws_route53_zone.main.zone_id
#    evaluate_target_health = false
#  }
#  depends_on = [
#    aws_route53_zone.main
#  ]
#}
