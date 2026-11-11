provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  default = "ami-0055977a6e828a4f4"
}

# Change var.ami and apply: the new instance comes up before the old one is deleted
resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = "t3.small"

  lifecycle {
    create_before_destroy = true
  }
}

# terraform destroy fails while this is set
resource "aws_instance" "main1" {
  ami           = var.ami1
  instance_type = "t3.small"

  lifecycle {
    prevent_destroy = true
  }
}

variable "ami1" {
  default = "ami-0eec78ea4cbaaf5bd"
}

# Change var.ami1 and apply: terraform shows no changes for this instance
resource "aws_instance" "main2" {
  ami           = var.ami
  instance_type = "t3.small"

  lifecycle {
    ignore_changes = [ami]
  }
}