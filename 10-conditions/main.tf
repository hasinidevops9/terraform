provider "aws" {
  region = "us-east-1"
}

# condition ? true_val : false_val
# Conditions pick a value. They do not decide whether a resource runs.

resource "aws_instance" "main" {
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = var.env == "prod" ? "t3.medium" : "t3.small"
}

variable "env" {
  default = "prod"
}

## Combine a condition with count to create a resource or not

variable "create_ec2" {
  default = false
}

resource "aws_instance" "optional" {
  count         = var.create_ec2 ? 1 : 0
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = "t3.micro"
}

## Condition in an output

variable "number" {
  default = 7
}

output "odd_or_even" {
  value = var.number % 2 == 1 ? "Given number is Odd Number" : "Given number is Even Number"
}