provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami                    = "ami-0eec78ea4cbaaf5bd"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-099e69caf2ac8fa5e"]
}

# Provisioners inside the instance run only once, at creation.
# Moving them to a null_resource lets us re-run them using triggers.
resource "null_resource" "test" {

  triggers = {
    instance = aws_instance.test.id # re-run when the instance is replaced
    # always = timestamp()          # re-run on every apply
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = aws_instance.test.public_ip
      user     = "ec2-user"
      password = "DevOps321"
    }
    inline = [
      "echo Hello >/tmp/some",
      "echo Hello1 >/tmp/some1"
    ]
  }
}