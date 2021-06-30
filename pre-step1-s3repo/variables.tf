variable "bucketname" {
  description = "S3 bucket name."
  type        = string
}
variable "reponame" {
  description = "ECR repo name."
  type        = string
}
variable "create_bucket" {
  description = "Controls if S3 bucket should be created."
  type        = bool
}
