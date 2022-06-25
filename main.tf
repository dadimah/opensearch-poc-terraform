## Creating opensearch-poc-vpc and Defining the CIDR block 40.0.0.0/16.
resource "aws_vpc" "opensearch-poc-vpc" {
  cidr_block       = var.opensearch-poc-vpc-main-cidr
  instance_tenancy = "default"
  tags             = local.tags
}

## Creating two subnets in two availability zones.
resource "aws_subnet" "subnet-az1" {
  vpc_id     = aws_vpc.opensearch-poc-vpc
  cidr_block = var.opensearch-poc-subnet-az1
  tags       = local.tags
}

resource "aws_subnet" "subnet-az2" {
  vpc_id     = aws_vpc.opensearch-poc-vpc
  cidr_block = var.opensearch-poc-subnet-az2
  tags       = local.tags
}

## Create OpenSearch-POC Security Group
resource "aws_security_group" "opensearh-poc-sg" {
  name        = var.opensearch-poc-sg
  description = "OpenSearch-POC Security Group"
  vpc_id      = aws_vpc.opensearch-poc-vpc.id

  ingress {
    description = "Allow Inbound traffic to Opensearch Domain"
    from_port   = 443
    to_port     = 443
    protocol    = "https"
    cidr_blocks = [aws_vpc.opensearch-poc-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}