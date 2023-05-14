resource "aws_security_group" "cluster" {
  name = "cluster"

  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "Allow access to the nodes from anywhere"

    from_port = 0
    to_port   = 0
    protocol  = "-1"

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

resource "aws_security_group" "lb" {
  name = "lb"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 6443
    to_port   = 6443
    protocol  = "TCP"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }
}