output "waf_arn" {
  description = "arn of the waf web acl"
  value       = aws_wafv2_web_acl.waf.arn
}

output "waf_id" {
  description = "id of the waf web acl"
  value       = aws_wafv2_web_acl.waf.id
}