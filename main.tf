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

resource "aws_instance" "kubernetes_master" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  tags = {
    Name = "kubernetes-master"
  }
}

resource "aws_instance" "kubernetes_worker" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key_pair.key_name
  tags = {
    Name = "kubernetes-worker"
  }
  count = 2
}
