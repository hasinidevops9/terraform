provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }
}

data "aws_security_group" "selected" {
  filter {
    name   = "group-name"
    values = ["allow-all"]
  }
}

output "ami" {
  value = data.aws_ami.ami
}

output "security_group" {
  value = data.aws_security_group.selected
}

# Using the data source values instead of hardcoding IDs
resource "aws_instance" "main" {
  ami                    = data.aws_ami.ami.image_id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = "datasource-test"
  }
}