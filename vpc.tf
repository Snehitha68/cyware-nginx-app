resource "aws_vpc" "cywarevpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = var.enable_dns_support

  tags = merge(var.commantags,
    { "Name" : "CywareVPC" }
  )
}

resource "aws_subnet" "cywarevpcpublicsubnets" {
  vpc_id            = aws_vpc.cywarevpc.id
  map_public_ip_on_launch = true
  count             = length(var.publicssubentscidrs)
  cidr_block        = element(var.publicssubentscidrs, count.index)
  availability_zone = element(var.aws_availabilty_zones, count.index)
  tags = merge(var.commantags,
    {
      "Name" = "cywarevpc-publicsubnet-${count.index + 1}"
    }
  )
}

resource "aws_subnet" "cywarevpcprivatesubents" {
  vpc_id            = aws_vpc.cywarevpc.id
  count             = length(var.privatesubentscidrs)
  cidr_block        = element(var.privatesubentscidrs, count.index)
  availability_zone = element(var.aws_availabilty_zones, count.index)
  tags = merge(var.commantags,
    {
      "Name" = "cywarevpc-privatesubnet-${count.index + 1}"
    }
  )
}


resource "aws_internet_gateway" "dempvpcigw" {
  vpc_id = aws_vpc.cywarevpc.id
  tags = merge(var.commantags,
    {
      "Name" = "cywarevpc-igw"
    }
  )
}

resource "aws_route_table" "cywarevpcpublicrt" {
  vpc_id = aws_vpc.cywarevpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dempvpcigw.id
  }
  tags = merge(var.commantags,
    {
      Name = "cywarevpc-publicrt"
    }
  )
}

resource "aws_route_table_association" "cywarevpcpublicrtassociation" {
  count          = length(var.publicssubentscidrs)
  subnet_id      = element(aws_subnet.cywarevpcpublicsubnets[*].id, count.index)
  route_table_id = aws_route_table.cywarevpcpublicrt.id
}

resource "aws_eip" "nateips" {
  count = length(var.publicssubentscidrs)
  vpc = true
  tags = merge(var.commantags,
    { "Name" = "Elastic-IP-${count.index + 1}" }
  )
}

resource "aws_nat_gateway" "cywarevpcnatgatways" {
  count         = length(var.publicssubentscidrs)
  allocation_id = element(aws_eip.nateips[*].id, count.index)
  subnet_id     = element(aws_subnet.cywarevpcpublicsubnets[*].id, count.index)
  tags = merge(var.commantags,
    { "Name" = "cywareVPC-NAT-${count.index + 1}" }
  )

   depends_on = [aws_internet_gateway.dempvpcigw]
}

resource "aws_route_table" "cywarevpcprivateroutetable" {
  vpc_id = aws_vpc.cywarevpc.id
  count  = length(var.privatesubentscidrs)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.cywarevpcnatgatways[*].id, count.index)
  }
  tags = merge(var.commantags, {
    Name = "cywarevpc-privatert-${count.index + 1}"
    }
  )
}


resource "aws_route_table_association" "cywarevpcnatassocation1a" {
  count          = length(var.privatesubentscidrs)
  subnet_id      = element(aws_subnet.cywarevpcprivatesubents[*].id, count.index)
  route_table_id = element(aws_route_table.cywarevpcprivateroutetable[*].id, count.index)
}



