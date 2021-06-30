variable "bucketname" {
  description = "S3 bucket name."
  type        = string
}
variable "create_origin_access_identity" {
  description = "Controls if CloudFront origin access identity should be created"
  type        = bool
}
variable "origin_access_identity_comment" {
  description = "CloudFront origin access identity comment."
  type        = string
}
variable "create_distribution" {
  description = "Controls if CloudFront distribution should be created"
  type        = bool
}
variable "domain_name" {
  description = "Domain name to access CF distribution."
  type        = string
}
