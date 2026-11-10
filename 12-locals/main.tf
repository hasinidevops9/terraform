variable "input" {
  default = {
    one   = "100"
    two   = "200"
    three = "300"
  }
}

locals {
  input_list = [for i, j in var.input : j]
}

output "out" {
  value = local.input_list
}

## Locals to reshape a complex variable

variable "dummy" {
  default = {
    apple = {
      price = 100
    }
    banana = {
      price = 200
    }
    citrus = {
      price = 300
    }
  }
}

locals {
  prices = { for x, y in var.dummy : x => y.price }
}

output "prices" {
  value = local.prices
}