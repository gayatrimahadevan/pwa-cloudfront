resource "aws_s3_bucket" "cp-bucket" {
  count  = var.create_bucket ? 1 : 0
  bucket = var.bucketname
}
resource "aws_ecr_repository" "demo" {
  name = var.reponame
}
