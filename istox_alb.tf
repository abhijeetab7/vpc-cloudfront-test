resource "aws_lb" "istox_aws_lb" {
  name               = "${local.lb_name}"
  internal           = "${local.lb_internal}"
  load_balancer_type = "${local.lb_type}"
  security_groups    = ["${aws_security_group.allow_tls.id}"]
  enable_deletion_protection = false
  subnets            = aws_subnet.istox_public.*.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.istox_vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.istox_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
