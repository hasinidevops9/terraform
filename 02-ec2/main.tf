provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "main" {
  ami           = "ami-0eec78ea4cbaaf5bd"
  instance_type = "t3.micro"

  tags = {
    Name = "test"
  }
}

# One resource referring to another resource's attribute.
# Terraform understands the dependency and creates the instance first.
resource "aws_route53_record" "main" {
  zone_id = "Z02185673PPMYAJHNLFI1"
  name    = "tf-test"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.private_ip]
}

output "private_ip" {
  value = aws_instance.main.private_ip
}