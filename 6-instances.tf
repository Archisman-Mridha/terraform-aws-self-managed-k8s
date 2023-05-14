resource "aws_instance" "master_nodes" {
  count = length(var.aws_zones)

  subnet_id = aws_subnet.public_subnets[count.index].id
  vpc_security_group_ids = [
    aws_security_group.cluster.id
  ]

  ami           = data.aws_ami.ubuntu.image_id
  instance_type = var.aws_instance_type
  root_block_device {
    volume_size = 25
  }

  tags = {
    format("kubernetes.io/cluster/%v", local.cluster_name) = "owned"
  }

  key_name = aws_key_pair.keypair.key_name

  lifecycle {
    ignore_changes = [
      ami,
      associate_public_ip_address
    ]
  }
}

/* resource "aws_instance" "worker_nodes" {
  count = length(var.aws_zones)

  subnet_id = aws_subnet.public_subnets[count.index].id
  vpc_security_group_ids = [
    aws_security_group.cluster.id
  ]

  ami           = data.aws_ami.ubuntu.image_id
  instance_type = var.aws_instance_type
  root_block_device {
    volume_size = 25
  }

  tags = {
    format("kubernetes.io/cluster/%v", local.cluster_name) = "owned"
  }

  key_name = aws_key_pair.keypair.key_name

  lifecycle {
    ignore_changes = [
      ami,
      associate_public_ip_address
    ]
  }
} */