data "aws_acm_certificate" "cert" {
    domain = "drnur.uk"
    statuses = [ "ISSUED" ]
    most_recent = true
  
}

resource "cloudflare_dns_record" "alb" {
  zone_id = var.cloudflare_zone_id
  name    = "drnur.uk"
  content = var.alb_dns
  type    = "CNAME"
  ttl     = 3600
  proxied = false
}