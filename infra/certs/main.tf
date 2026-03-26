data "aws_acm_certificate" "cert" {
    domain = "drnur.uk"
    statuses = [ "ISSUED" ]
    most_recent = true
  
}