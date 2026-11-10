provider "aws" {
  region = "us-east-1"
}

# resource "aws_security_group" "main" {
#
#   for_each = var.component
#   name = each.key
#
#   ingress {
#     from_port        = 22
#     to_port          = 22
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port        = 80
#     to_port          = 80
#     protocol         = "TCP"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }
#
# }

## The above approach will not work for different ports for different inputs. Plus we end up writing multiple ingress blocks

resource "aws_security_group" "main" {

  for_each = var.component
  name     = each.key

  dynamic "ingress" {
    for_each = each.value["ports"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
      description = ingress.key
    }
  }

  # Terraform removes the AWS default outbound rule, so add it back
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

variable "component" {
  default = {
    one = {
      ports = {
        ssh   = 22
        http  = 80
        https = 443
      }
    }
    two = {
      ports = {
        ssh = 22
        app = 8080
      }
    }
  }
}