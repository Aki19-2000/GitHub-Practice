provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "my_vpc1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC1"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MySubnet"
  }
}

# Create an Internet Gateway for the VPC to allow outbound internet access
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

# Create a route table to allow internet access
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "my_subnet_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create a security group
resource "aws_security_group" "my_security_group1" {
  name        = "my_security_group1"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

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

# Launch an EC2 instance in the VPC
resource "aws_instance" "my_instance1" {
  ami           = "ami-085ad6ae776d8f09c"  # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id  # Specify the subnet where the instance will launch

  security_groups = [aws_security_group.my_security_group1.name]  # Reference the correct security group

  tags = {
    Name = "MyInstance1"
  }
}
