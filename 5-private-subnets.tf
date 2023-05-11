resource "aws_subnet" "private_subnets" {
  count = length(var.aws_zones)

  availability_zone = var.aws_zones[count.index]

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.aws_vpc_cidr, 8, length(var.aws_zones) + count.index)
}

resource "aws_route_table" "private_subnet_route_tables" {
  count = length(var.aws_zones)

  vpc_id = aws_vpc.vpc.id

  // All instances in a private subnet can access the NAT Gateway instance
  // in the public subnet present in the same zone
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateways[count.index].id
  }
}

resource "aws_route_table_association" "private_subnet_route_table_associations" {
  count = length(var.aws_zones)

  route_table_id = aws_route_table.private_subnet_route_tables[count.index].id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}
