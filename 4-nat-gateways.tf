resource "aws_eip" "nat_eips" {
  count = length(var.aws_zones)

  vpc = true

  depends_on = [
    aws_internet_gateway.internet_gateway
  ]
}

resource "aws_nat_gateway" "nat_gateways" {
  count = length(var.aws_zones)

  subnet_id     = aws_subnet.public_subnets[count.index].id
  allocation_id = aws_eip.nat_eips[count.index].id
}
