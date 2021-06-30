output "repository_url" {
  description = "ECR repository URL of Docker image"
  value       = aws_ecr_repository.demo.repository_url
}
output "bucket_name" {
  description = "S3 bucket name."
  value       = aws_s3_bucket.cp-bucket[0].bucket
}
