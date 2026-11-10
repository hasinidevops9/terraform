module "sample" {
  source  = "./sample"
  message = var.message
  a       = var.a
  b       = var.b
}

# Same module used again, taking input from the first module's output
module "sample1" {
  source  = "./sample"
  message = "Output of first module is ${module.sample.multiply}"
  a       = module.sample.multiply
  b       = 2
}

variable "message" {
  default = "Hello World"
}

variable "a" {
  default = 10
}

variable "b" {
  default = 200
}

output "output_from_module" {
  value = module.sample.multiply
}

output "output_from_module1" {
  value = module.sample1.multiply
}


## When not to use modules.
## For a single project, we have just multiple environments
## and for that we dont need to declare any modules, because
## it is just the env inputs will change and the code is all local.


## When to use the modules.
## For a larger projects, where platform engineering practices
## comes into picture, at those places modules should be common
## to avoid duplicate effort / implement standards across organization
## In such cases the module needs to be central and that where we
## need to start using modules.