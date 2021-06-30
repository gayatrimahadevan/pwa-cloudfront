data "aws_ecr_repository" "repo" {
  name = var.image_name
}
resource "null_resource" "push" {

  provisioner "local-exec" {
    command     = "${path.module}'/push.sh' ${data.aws_ecr_repository.repo.repository_url} ${var.tag}"
    interpreter = ["bash", "-c"]
  }
}
