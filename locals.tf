locals {
  name_prefix = "istox"

  #load balancer configuration
  lb_bucket_name = "lb-logs"
  lb_type        = "application"
  lb_name        = "istox-aws-lb"
  lb_internal    = "false"

  #vpc configuration
  public_subnets_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]
  private_subnets_cidr = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
  ]
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  #cloudfront configuration
  default_origin = "istoxOrigin"
}