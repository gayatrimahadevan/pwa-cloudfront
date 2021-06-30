variable "AWS_REGION" {
  default = "us-east-1"
}
variable "image_name" {
  description = "Name of Docker image"
  type        = string
}
variable "tag" {
  description = "Tag to use for deployed Docker image"
  type        = string
}
variable "stage" {
  description = "Tag to use for deployed Docker image"
  type        = string
}
variable "deploy_to_prod" {
  description = "Tag to use for deployed Docker image"
  type        = bool
}

variable "image_uri" {
  description = "uri of ECR image"
  type        = string
}
#variable "push_script" {
#  description = "Path to script to build and push Docker image"
#  type        = string
#}
