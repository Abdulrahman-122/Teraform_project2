resource "aws_wafv2_web_acl" "waf"{
    name="gym-web-acl"
    scope="REGIONAL"
    default_action {
      allow {
        
      }
    }
    rule {
      name="CommonRules"
      priority = 1
      override_action {
        none {
          
        }
      }
    statement {
      managed_rule_group_statement {
        name = "AwsManagedRulesset"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "AWSCommonRules"
      sampled_requests_enabled = true
    }
}
    rule {
      name = "AWSknownBadInputs"
      priority = 2
      override_action {
        none{}
      }
      statement {
        managed_rule_group_statement {
          name="AWSManagedRulesBadInputSets"
          vendor_name = "AWS"
        }
      }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "AWSKnownBadInputs"
      sampled_requests_enabled = true
    }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name = "gym-web-acl"
      sampled_requests_enabled = true
    }
}
resource "aws_wafv2_web_acl_association" "waf_alb"{
    resource_arn = var.alb_arn
    web_acl_arn = aws_wafv2_web_acl.waf.arn
}