provider "aws" {
  region = "us-east-1"
}

# Bring an existing server (created manually from the console) under terraform.
# 1. Write the resource block matching the server
# 2. Add an import block with the server id
# 3. terraform plan  -> shows "1 to import"
# 4. terraform apply -> server is now in the state file. The import block can then be removed.

import {
  to = aws_instance.workstation
  id = var.instance_id
}

variable "instance_id" {
  default = "i-0123456789abcdef0" # replace with your workstation instance id
}

resource "aws_instance" "workstation" {
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = "t3.small"

  tags = {
    Name = "workstation"
  }
}

output "private_ip" {
  value = aws_instance.workstation.private_ip
}

## Don't want to write the resource block by hand?
## Keep only the import block and run:
##   terraform plan -generate-config-out=generated.tf
##
## Older CLI way (no import block):
##   terraform import aws_instance.workstation i-0123456789abcdef0