resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

data "tls_public_key" "public_key" {
  private_key_pem = tls_private_key.private_key.private_key_pem
}

resource "aws_key_pair" "keypair" {
  key_name_prefix = "keypair"
  public_key      = data.tls_public_key.public_key.public_key_openssh
}

resource "local_file" "private_key_file" {
  filename = "./outputs/private-key.pem"
  content  = tls_private_key.private_key.private_key_pem
}
