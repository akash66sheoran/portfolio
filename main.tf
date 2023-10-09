terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_key_pair" "portfolio_key" {
  key_name = "portfolio-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "my_security_group" {
  name = "my-security-group"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "portfolio_website" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = aws_key_pair.portfolio_key.key_name
  security_groups = ["my-security-group"]
  tags = {
    Name = "portfolio"
  }
}

output "public_ip" {
  value = aws_instance.portfolio_website.public_ip
}
