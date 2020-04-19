output "vpc_name" {
  value = "${aws_vpc.istox_vpc.id}"
}

output "alb_name" {
  value = "${aws_lb.istox_aws_lb.name}"
}

output "alb_arn" {
  value = "${aws_lb.istox_aws_lb.arn}"
}

output "cloudfront_distribution_domain" {
  value = "${aws_cloudfront_distribution.s3_distribution.domain_name}"
}

output "cloudfront_distribution_arn" {
  value = "${aws_cloudfront_distribution.s3_distribution.arn}"
}