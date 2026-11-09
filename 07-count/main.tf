provider "aws" {
  region = "us-east-1"
}

resource "null_resource" "test" {
  count = 3
}

variable "components" {
  default = ["frontend", "mongodb", "catalogue"]
}

resource "aws_instance" "main" {
  count         = length(var.components)
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = "t3.micro"

  tags = {
    Name = var.components[count.index]
  }
}

output "private_ips" {
  value = aws_instance.main[*].private_ip
}

## Problem with count: remove "mongodb" from the list and run plan.
## catalogue shifts from index 2 to 1, so terraform wants to recreate it.
## for_each (next topic) solves this.