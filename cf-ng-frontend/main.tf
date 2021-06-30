resource "aws_acm_certificate" "democert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}
resource "aws_cloudfront_origin_access_identity" "cp-s3-origin" {
  count   = var.create_origin_access_identity ? 1 : 0
  comment = var.origin_access_identity_comment
}
resource "aws_cloudfront_distribution" "cp-distribution" {
  count               = var.create_distribution ? 1 : 0
  enabled             = true
  aliases             = [var.domain_name]
  default_root_object = "index.html"
  price_class         = "PriceClass_All"
  origin {
    domain_name = data.aws_s3_bucket.cp-bucket.bucket_regional_domain_name
    origin_id   = "cp-s3-originid"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.cp-s3-origin[0].cloudfront_access_identity_path
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "cp-s3-originid"
    viewer_protocol_policy = "allow-all"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.democert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "IN"]
    }
  }
}
resource "aws_s3_bucket_policy" "cf-read" {
  bucket = data.aws_s3_bucket.cp-bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}
