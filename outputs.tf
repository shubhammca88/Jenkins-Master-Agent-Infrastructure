output "server_ids" {
  description = "IDs of all servers"
  value       = aws_instance.servers[*].id
}

output "server_public_ips" {
  description = "Public IP addresses of all servers"
  value       = [for instance in aws_instance.servers : instance.public_ip != null ? instance.public_ip : instance.private_ip]
}

output "server_details" {
  description = "Server names and IPs"
  value       = zipmap(slice(var.server_names, 0, var.server_count), [for instance in aws_instance.servers : instance.public_ip != null ? instance.public_ip : instance.private_ip])
}

output "jenkins_master_ip" {
  description = "Public IP address of Jenkins Master (first server)"
  value       = var.server_count > 0 ? aws_instance.servers[0].public_ip : null
}

output "jenkins_agent_ips" {
  description = "Public IP addresses of Jenkins Agents (remaining servers)"
  value       = var.server_count > 1 ? slice(aws_instance.servers[*].public_ip, 1, var.server_count) : []
}