provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "test" {
  for_each = var.inputs
}

variable "inputs" {
  default = {
    z = 300
    x = 100
    y = 200
  }
}

## Map of maps - each.key is the name, each.value holds the settings

variable "components" {
  default = {
    frontend = {
      instance_type = "t3.micro"
    }
    mongodb = {
      instance_type = "t3.small"
    }
    catalogue = {
      instance_type = "t3.micro"
    }
  }
}

resource "aws_instance" "main" {
  for_each      = var.components
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = each.value["instance_type"]

  tags = {
    Name = each.key
  }
}

## for_each on a list - convert it to a set first

variable "vegetables" {
  default = ["carrot", "capsicum"]
}

resource "null_resource" "vegetables" {
  for_each = toset(var.vegetables)
}