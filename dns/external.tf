# Main record point to bastion server
resource "aws_route53_record" "naked_public" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "krolm.com"
  type = "A"
  ttl  = var.dns_ttl
  records = ["18.236.187.191"]
}

resource "aws_route53_record" "www_public" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "www.krolm.com"
  type = "CNAME"
  ttl  = var.dns_ttl
  records = ["krolm.com"]
}

# Mail records
resource "aws_route53_record" "mx_public" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "krolm.com"
  type = "MX"
  ttl  = var.dns_ttl
  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "5 ALT1.ASPMX.L.GOOGLE.COM",
    "5 ALT2.ASPMX.L.GOOGLE.COM",
    "10 ALT3.ASPMX.L.GOOGLE.COM",
    "10 ALT4.ASPMX.L.GOOGLE.COM",
    "15 6jlwxghygpvrekes3c2apmzik3biydbhksltxuvasngd3ca6kgnq.mx-verification.google.com."
  ]
}

# Google and Atlassian TXT verification
resource "aws_route53_record" "txt_public" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "krolm.com"
  type = "TXT"
  ttl  = var.dns_ttl
  records = [
    "google-site-verification=8ldrmPgz6xIokti0B7MoVsKMDCdUlzvSoJNMPYgeUZs",
    "atlassian-domain-verification=ixOGQvuhjvPqD718z/iJmLuAXbHN3waSoRLJgjojO5hVboaWm/jZW5aoQz/W5UWk"
  ]
}

resource "aws_route53_record" "cname_public" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "pxutbgjkll2l.krolm.com."
  type = "CNAME"
  ttl  = var.dns_ttl
  records = ["gv-262tuf47y32wip.dv.googlehosted.com"]
}

# GitHub verification
resource "aws_route53_record" "txt_github" {
  zone_id = data.terraform_remote_state.vpc_dev.outputs.dns_main
  name = "_github-challenge-krolm.krolm.com."
  type = "TXT"
  ttl  = var.dns_ttl
  records = [
    "94196d82cb"
  ]
}
