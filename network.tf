# Key Pair for EC2 login
resource "aws_key_pair" "server_key" {
  key_name   = var.key_name
  public_key = fileexists(var.public_key_path) ? file(var.public_key_path) : null
}

resource "aws_security_group" "server_sg" {
  count       = var.server_count
  name        = "${var.server_names[count.index]}-${var.environments[count.index]}-sg"
  description = "Security group for ${var.server_names[count.index]} (${var.environments[count.index]})"

  dynamic "ingress" {
    for_each = var.server_ports[count.index]
    content {
      description = ingress.value == 22 ? "SSH" : ingress.value == 80 ? "HTTP" : ingress.value == 443 ? "HTTPS" : ingress.value == 3306 ? "MySQL" : ingress.value == 8000 ? "Custom-8000" : "Port-${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allowed_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.server_names[count.index]}-${var.environments[count.index]}-sg"
    Environment = var.environments[count.index]
    Server      = var.server_names[count.index]
  }
}