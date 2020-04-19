provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "istox_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "${local.enable_dns_support}"
  enable_dns_hostnames = "${local.enable_dns_hostnames}"

  tags = {
    Name = "${local.name_prefix}_vpc"
  }
}

resource "aws_subnet" "istox_public" {
  count             = "${length(local.public_subnets_cidr)}"
  vpc_id            = "${aws_vpc.istox_vpc.id}"
  cidr_block        = "${local.public_subnets_cidr[count.index]}"

  tags = {
    Name = "${local.name_prefix}_public_subnet"
  }
}

resource "aws_subnet" "istox_private" {
  count             = "${length(local.private_subnets_cidr)}"
  vpc_id            = "${aws_vpc.istox_vpc.id}"
  cidr_block        = "${local.private_subnets_cidr[count.index]}"

  tags = {
    Name = "${local.name_prefix}_private_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.istox_vpc.id}"

  tags = {
    Name = "main"
  }
}
