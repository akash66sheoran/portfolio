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

resource "aws_key_pair" "my_key_pair" {
  key_name = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "portfolio_website" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  tags = {
    Name = "portfolio"
  }
}

output "public_ip" {
  value = aws_instance.portfolio_website.public_ip
}
