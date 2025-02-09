provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow all inbound traffic"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance1" {
  ami           = "ami-085ad6ae776d8f09c"  # Replace with your AMI ID
  instance_type = "t2.micro"

  # Correct use of security_groups (plural)
  security_groups = [aws_security_group.my_security_group.name]

  tags = {
    Name = "MyInstance"
  }
}
