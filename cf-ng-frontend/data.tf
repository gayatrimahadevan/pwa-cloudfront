data "aws_s3_bucket" "cp-bucket" {
  bucket = var.bucketname
}
data "aws_iam_policy_document" "s3_policy" {
  statement {
    sid       = "CloudFrontPrivateContent"
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.cp-bucket.arn}/*"]
    effect    = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.cp-s3-origin[0].iam_arn]
    }
  }
}