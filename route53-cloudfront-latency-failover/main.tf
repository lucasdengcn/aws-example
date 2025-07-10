variable "zone_id" {
  type        = string
  description = "Route53 hosted zone ID"
}

variable "record_name" {
  type        = string
  description = "DNS record name (e.g. www.example.com)"
}

variable "primary_cf_domain" {
  type        = string
  description = "Primary CloudFront distribution domain name"
}

variable "secondary_cf_domain" {
  type        = string
  description = "Secondary CloudFront distribution domain name"
}

variable "primary_region" {
  type        = string
  description = "AWS region for primary latency routing"
}

variable "secondary_region" {
  type        = string
  description = "AWS region for secondary latency routing"
}

locals {
  cloudfront_zone_id = "Z2FDTNDATAQYW2" # CloudFront fixed hosted zone ID
}

resource "aws_route53_health_check" "primary" {
  fqdn              = var.primary_cf_domain
  type              = "HTTPS"
  port              = 443
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_health_check" "secondary" {
  fqdn              = var.secondary_cf_domain
  type              = "HTTPS"
  port              = 443
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  set_identifier = "primary-${var.primary_region}"

  latency_routing_policy {
    region = var.primary_region
  }

  alias {
    name                   = var.primary_cf_domain
    zone_id                = local.cloudfront_zone_id
    evaluate_target_health = true
  }

  health_check_id = aws_route53_health_check.primary.id
  failover        = "PRIMARY"
}

resource "aws_route53_record" "secondary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"

  set_identifier = "secondary-${var.secondary_region}"

  latency_routing_policy {
    region = var.secondary_region
  }

  alias {
    name                   = var.secondary_cf_domain
    zone_id                = local.cloudfront_zone_id
    evaluate_target_health = true
  }

  health_check_id = aws_route53_health_check.secondary.id
  failover        = "SECONDARY"
}
