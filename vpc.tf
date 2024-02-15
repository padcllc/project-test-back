data "aws_region" "current" {}
data "aws_availability_zones" "current" {}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public-associations1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public-associations2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "terraformInternetGateway"
  }

}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraformVpc"
  }
}

resource "aws_subnet" "publicsubnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.101.0/24"
  availability_zone       = data.aws_availability_zones.current.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name              = "terraformPublic1"
    availability_zone = data.aws_availability_zones.current.names[0]
  }
}
resource "aws_subnet" "publicsubnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.102.0/24"
  availability_zone       = data.aws_availability_zones.current.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name              = "terraformPublic2"
    availability_zone = data.aws_availability_zones.current.names[1]
  }
}
resource "aws_subnet" "privatesubnet1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.current.names[0]
  tags = {
    Name              = "terraformPrivate1"
    availability_zone = data.aws_availability_zones.current.names[0]
  }
}
resource "aws_subnet" "privatesubnet2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.current.names[1]
  tags = {
    Name              = "terraformPrivate2"
    availability_zone = data.aws_availability_zones.current.names[1]
  }
}
