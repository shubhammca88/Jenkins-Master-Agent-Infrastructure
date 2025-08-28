# Elastic IP for EC2 instances
resource "aws_eip" "server_eip" {
  count    = var.enable_elastic_ip ? var.server_count : 0
  instance = aws_instance.servers[count.index].id
  domain   = "vpc"

  tags = {
    Name        = "${var.server_names[count.index]}-eip"
    Environment = var.environments[count.index]
  }

  depends_on = [aws_instance.servers]
}