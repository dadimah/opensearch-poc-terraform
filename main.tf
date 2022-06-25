## Creating opensearch-poc-vpc and Defining the CIDR block 40.0.0.0/16.
resource "aws_vpc" "opensearch-poc-vpc" {  
  cidr_block       = var.opensearch-poc-vpc-main-cidr
  instance_tenancy = "default"
  tags = merge(local.tags, {
    Name = "opensearch-poc-vpc"
    }
  )
}

## Creating two subnets in two availability zones.
# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "subnet-az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id     = aws_vpc.opensearch-poc-vpc.id
  cidr_block = var.opensearch-poc-subnet-az1
  tags = merge(local.tags, {
    Name = "opensearch-vpc-subnet-az1"
    }
  )
}

resource "aws_subnet" "subnet-az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id     = aws_vpc.opensearch-poc-vpc.id
  cidr_block = var.opensearch-poc-subnet-az2
  tags = merge(local.tags, {
    Name = "opensearch-vpc-subnet-az2"
    }
  )
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
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.opensearch-poc-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, {
    Name = "opensearch-vpc-sg"
    }
  )
}