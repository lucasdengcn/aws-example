# Terraform Route53 CloudFront Failover with Latency Routing Module

This module creates Route53 DNS records pointing to two CloudFront distributions with:

- Latency routing policy to route users based on lowest latency to region.
- Failover routing policy to switch to secondary if primary fails.
- Health checks on CloudFront distributions to enable failover.

## Usage

```hcl
module "route53_cf_failover" {
  source = "./route53-cloudfront-latency-failover"

  zone_id            = "Z123456789EXAMPLE"
  record_name        = "www.example.com"
  primary_cf_domain  = "d123primary.cloudfront.net"
  secondary_cf_domain = "d456secondary.cloudfront.net"
  primary_region     = "us-east-1"
  secondary_region   = "us-west-2"
}
