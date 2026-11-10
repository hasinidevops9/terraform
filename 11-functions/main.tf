# https://developer.hashicorp.com/terraform/language/functions
# Try any function interactively with: terraform console

variable "some" {
  default = "hello world"
}

output "some_incaps" {
  value = upper(var.some)
}

output "some_lower" {
  value = lower("HELLO WORLD")
}

output "some_title" {
  value = title("hello world")
}

output "some_length" {
  value = length(var.some)
}

output "some_substr" {
  value = substr(var.some, 0, 5)
}

output "some_join" {
  value = join("-", ["hello", "world", "terraform"])
}

output "some_split" {
  value = split(" ", var.some)
}

output "some_replace" {
  value = replace(var.some, "world", "terraform")
}

output "some_max" {
  value = max(10, 20, 30)
}

output "some_format" {
  value = format("Hello, %s! You have %d items.", "user", 5)
}

## Collection functions - safe ways to read lists and maps

variable "fruits" {
  default = ["apple", "banana"]
}

output "fruit" {
  # var.fruits[2] fails, element() wraps around
  value = element(var.fruits, 2)
}

variable "fruit_with_stock" {
  default = {
    apple = {
      stock = 100
    }
  }
}

output "fruit_stock" {
  # banana key does not exist, try() returns the fallback
  value = try(var.fruit_with_stock["banana"], 0)
}

output "fruit_stock_price" {
  # price key does not exist, lookup() returns the default
  value = lookup(var.fruit_with_stock["apple"], "price", 2)
}