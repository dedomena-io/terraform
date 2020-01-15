# DEV records
# MX
resource "aws_route53_record" "mx_private" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_dev
  name = "dev.krolm.com"
  type = "MX"
  ttl  = var.dns_ttl
  records = [
    "0 mail.dev.krolm.com"
  ]
}

resource "aws_route53_record" "mail_private" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_dev
  name = "mail.dev.krolm.com"
  type = "CNAME"
  ttl  = var.dns_ttl
  records = [
    "ASPMX.L.GOOGLE.COM"
  ]
}

# Other records
