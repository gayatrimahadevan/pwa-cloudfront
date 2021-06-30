output "repository_url" {
  description = "ECR repository URL of Docker image"
  value       = data.aws_ecr_repository.repo.repository_url
}
output "tag" {
  description = "Docker image tag"
  value       = var.tag
}
output "dev_url" {
  value = aws_api_gateway_deployment.dev.invoke_url
}
output "prod_url" {
  value = aws_api_gateway_deployment.prod.invoke_url
}

