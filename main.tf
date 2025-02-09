provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "my_vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC1"
  }
}


resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc1.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet"
  }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc1.id

  tags = {
    Name = "MyInternetGateway"
  }
}


resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}


resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}


resource "aws_security_group" "my_security_group1" {
  name        = "my_security_group1"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.my_vpc1.id

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

  tags = {
    Name = "MySecurityGroup1"
  }
}


resource "aws_instance" "my_instance1" {
  ami           = "ami-085ad6ae776d8f09c"  
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id  

  security_groups = [aws_security_group.my_security_group1.name] 

  tags = {
    Name = "MyInstance1"
  }
}
