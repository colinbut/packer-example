packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_access_key" {
    type = "string"
}

variable "aws_secret_key" {
    type        = "string"
    sensitive   = true
}

source "amazon-ebs" "ubuntu" {
    ami_name        = "image-with-redis {{timestamp}}"
    instance_type   = "t2.micro"
    region          = "eu-west-1"
    access_key      = var.aws_access_key
    secret_key      = var.secret_key
    source_ami_filter {
        filters = {
            name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
            root-device-type    = "ebs"
            virtualization-type = "hvm"
        }
        most_recent = true
        owners      = ["099720109477"]
    }
    ssh_username = "ubuntu"
}

build {
    name = "image-with-redis {{timestamp}}"
    sources = [
        "source.amazon-ebs.ubuntu"
    ]

    provisioner "shell" {
        inline = [
            "sleep 30",
            "sudo apt-get update",
            "sudo apt-get install -y redis-server"
        ]
    }
}
