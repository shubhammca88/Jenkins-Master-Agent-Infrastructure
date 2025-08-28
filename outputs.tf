output "server_ids" {
  description = "IDs of all servers"
  value       = aws_instance.servers[*].id
}

output "server_public_ips" {
  description = "Public IP addresses of all servers"
  value       = var.enable_elastic_ip ? aws_eip.server_eip[*].public_ip : [for instance in aws_instance.servers : instance.public_ip != null ? instance.public_ip : instance.private_ip]
}

output "server_elastic_ips" {
  description = "Elastic IP addresses of all servers (if enabled)"
  value       = var.enable_elastic_ip ? aws_eip.server_eip[*].public_ip : []
}

output "server_details" {
  description = "Server names and IPs"
  value       = zipmap(slice(var.server_names, 0, var.server_count), var.enable_elastic_ip ? aws_eip.server_eip[*].public_ip : [for instance in aws_instance.servers : instance.public_ip != null ? instance.public_ip : instance.private_ip])
}

output "jenkins_master_ip" {
  description = "Public IP address of Jenkins Master"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_agent_ips" {
  description = "Public IP addresses of Jenkins Agents"
  value       = aws_instance.jenkins_agents[*].public_ip
}