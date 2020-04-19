variable "availability_zones" {
  description = "AZ to spread VPC subnets over."
  type        = "string"
  default     = "ap-southeast-1"
}

variable "private_subnets" {
  description = "private subnets"
  type        = list(string)
  default = null
}

variable "public_subnets" {
  description = "public subnets"
  type        = list(string)
  default     = null
}
