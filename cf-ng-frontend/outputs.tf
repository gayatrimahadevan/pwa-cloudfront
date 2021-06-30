output "distribution" {
  description = "CloudFront distribution"
  value       = var.create_distribution ? aws_cloudfront_distribution.cp-distribution[0].domain_name:"Distribution to be Created."
}
output "cert_arn" {
  description = "Viewer Certificate name."
  value       = aws_acm_certificate.democert.arn
}
output "cert_status" {
  description = "Viewer Certificate status."
  value       = aws_acm_certificate.democert.status
}
