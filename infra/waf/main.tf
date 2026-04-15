resource "aws_wafv2_web_acl" "waf" {
  name        = "app-waf"
  description = "WAF for alb"
  scope       = "REGIONAL"   

  default_action {
    allow {}   ##this will allow all traffic
  }

  rule {
    name     = "aws-managed-common-rules"
    priority = 1  

    override_action {
      none {}  
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"   
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-common-rules"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "aws-managed-known-bad-inputs"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"   ##this blocks alr known bad inputs
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-known-bad-inputs"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "app-waf"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "app-waf"
  }
}

resource "aws_wafv2_web_acl_association" "waf_alb" {
  resource_arn = var.aws_alb  
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}