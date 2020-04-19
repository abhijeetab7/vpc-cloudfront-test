resource "aws_s3_bucket" "istox_origin" {
  bucket = "istox-origin"
  acl    = "private"

  tags = {
    Name = "Static origin content bucket"
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    #domain_name = "${data.aws_s3_bucket.static_origin.bucket_domain_name}"
    domain_name = "${aws_s3_bucket.istox_origin.bucket_regional_domain_name}"
    origin_id   = "${local.default_origin}"
  }

  origin {
    domain_name = "${aws_lb.istox_aws_lb.dns_name}"
    origin_id   = "ALB-${aws_lb.istox_aws_lb.name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Static content"
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.default_origin}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/istox-testing/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    #target_origin_id = "${aws_lb.istox_aws_lb.name}"
    target_origin_id = "ALB-${aws_lb.istox_aws_lb.name}"

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "testing"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
