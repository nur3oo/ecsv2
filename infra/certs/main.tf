data "aws_acm_certificate" "cert" {
    domain = "drnur.uk"
    statuses = [ "ISSUED" ]
    most_recent = true
  
}

resource "aws_cloudflare_record" "alb" {
  zone_id = var.cloudflare_zone_id
  name    = "drnur.uk"
  value   = var.alb_dns
  type    = "CNAME"
  proxied = false
}