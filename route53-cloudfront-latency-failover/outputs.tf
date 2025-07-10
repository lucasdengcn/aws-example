output "primary_record_fqdn" {
  value       = aws_route53_record.primary.fqdn
  description = "Fully qualified domain name of primary Route53 record"
}

output "secondary_record_fqdn" {
  value       = aws_route53_record.secondary.fqdn
  description = "Fully qualified domain name of secondary Route53 record"
}

output "primary_health_check_id" {
  value       = aws_route53_health_check.primary.id
  description = "Primary health check ID"
}

output "secondary_health_check_id" {
  value       = aws_route53_health_check.secondary.id
  description = "Secondary health check ID"
}
