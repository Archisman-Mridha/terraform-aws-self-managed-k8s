resource "aws_security_group" "cluster" {
  name = "cluster"

  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow all inter-communications between cluster nodes"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    description = "Allow access to the Kubernetes API server from anywhere"

    from_port = 6443
    to_port   = 6443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
