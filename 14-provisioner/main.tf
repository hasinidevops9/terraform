provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami                    = "ami-0eec78ea4cbaaf5bd"
  instance_type          = "t3.small"

  # Runs on the machine where terraform runs
  provisioner "local-exec" {
    command = "echo Instance ${self.id} created with IP ${self.private_ip}"
  }

  # Runs on the created server
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = self.public_ip
      user     = "ec2-user"
      password = "DevOps321"
    }
    inline = [
      "echo Hello >/tmp/some"
    ]
  }
}