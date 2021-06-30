#!/bin/bash
# 
# Gets a Docker image and pushes to an AWS ECR repository
#
#

set -ex

repository_url="$1"
tag="${2:-latest}"

region="$(echo "$repository_url" | cut -d. -f4)"
image_name="$(echo "$repository_url" | cut -d/ -f2)"

(aws ecr get-login-password --region "$region"|docker login --username AWS --password-stdin "$repository_url")
docker build -f quotes/Dockerfile quotes --tag "$repository_url":"$tag"
docker push "$repository_url":"$tag"
