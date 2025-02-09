provider "aws" {
  region  = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "MySubnet"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow inbound HTTP and SSH"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_instance1" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  security_group = aws_security_group.my_security_group.id
  tags = {
    Name = "MyInstance"
  }
}
