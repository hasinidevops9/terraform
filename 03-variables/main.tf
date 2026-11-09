variable "x" {
  default = "abc"
}

variable "y" {
  default = 10
}

variable "z" {
  default = false
}

variable "example1" {
  default = [1, "a", false, 2]
}

variable "example2" {
  default = {
    a = "foo"
    b = 123
    x = "bar"
  }
}

output "x" {
  value = var.x
}

output "x1" {
  value = "x is ${var.x}"
}

# In list, In terraform , index starts from zero

output "example1" {
  value = var.example1[2]
}

output "example2" {
  value = var.example2["a"]
}

## Variables with type constraints

variable "env" {
  type    = string
  default = "dev"
}

variable "instance_count" {
  type    = number
  default = 2
}

variable "enabled" {
  type    = bool
  default = true
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "image_ids" {
  type = map(string)
  default = {
    dev  = "ami-0eec78ea4cbaaf5bd"
    prod = "ami-0eec78ea4cbaaf5bd"
  }
}

output "first_az" {
  value = var.availability_zones[0]
}

output "image_for_env" {
  value = var.image_ids[var.env]
}

## Variable without a default - terraform will ask for the value
## or pass it with: terraform apply -var input=hello

variable "input" {}

output "input" {
  value = var.input
}