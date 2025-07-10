variable "zone_id" {
  description = "Route53 hosted zone ID"
  type        = string
}

variable "record_name" {
  description = "DNS record name (e.g. www.example.com)"
  type        = string
}

variable "primary_cf_domain" {
  description = "Primary CloudFront distribution domain name"
  type        = string
}

variable "secondary_cf_domain" {
  description = "Secondary CloudFront distribution domain name"
  type        = string
}

variable "primary_region" {
  description = "AWS region for primary latency routing"
  type        = string
}

variable "secondary_region" {
  description = "AWS region for secondary latency routing"
  type        = string
}
