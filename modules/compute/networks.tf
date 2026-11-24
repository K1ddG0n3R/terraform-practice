resource "aws_vpc" "vpc-1" {
  cidr_block = "172.16.0.0/16"
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"
}
