provider "aws" {
  region = "us-east-1"
}

module "route53_cf_failover" {
  source = "../../route53-cloudfront-latency-failover/"

  zone_id             = "Z123456789EXAMPLE"
  record_name         = "www.example.com"
  primary_cf_domain   = "d123primary.cloudfront.net"
  secondary_cf_domain = "d456secondary.cloudfront.net"
  primary_region      = "us-east-1"
  secondary_region    = "us-west-2"
}
