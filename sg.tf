resource "aws_security_group" "alb_public" {
  count       = var.INTERNAL ? 0 : 1
  name        = "roboshop-public-alb-${var.ENV}"
  description = "roboshop-public-alb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //  ingress {
  //    description = "HTTPS"
  //    from_port   = 443
  //    to_port     = 443
  //    protocol    = "tcp"
  //    cidr_blocks = ["0.0.0.0/0"]
  //  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshop-public-alb-${var.ENV}"
  }
}

resource "aws_security_group" "alb_private" {
  count       = var.INTERNAL ? 1 : 0
  name        = "roboshop-private-alb-${var.ENV}"
  description = "roboshop-private-alb-${var.ENV}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshop-private-alb-${var.ENV}"
  }
}