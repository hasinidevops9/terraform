provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "main" {
  for_each      = var.servers
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = "t3.micro"

  tags = {
    Name = each.key
  }
}

variable "servers" {
  default = {
    one   = ""
    two   = ""
    three = ""
  }
}

output "instance_ids" {
  value = [for o in aws_instance.main : o.id]
}

output "ids_with_name" {
  value = { for i, j in aws_instance.main : i => j.id }
}

## Splat with count based resources: resource[*].attribute

resource "null_resource" "count" {
  count = 2
}

output "null_ids" {
  value = null_resource.count[*].id
}

## for expressions on plain variables

variable "x" {
  default = {
    a = 100
    b = 200
    c = 300
  }
}

variable "y" {
  default = [100, 200, 300]
}

output "xval" {
  value = [for k, v in var.x : v]
}

output "xmap" {
  value = { for k, v in var.x : "${k}1" => v }
}

output "ymap" {
  value = { for v in var.y : "a${v}" => v }
}

output "filter" {
  value = [for v in var.y : v if v > 100]
}