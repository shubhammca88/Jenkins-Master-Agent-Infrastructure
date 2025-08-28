# Jenkins Master-Agent Infrastructure with Terraform

Deploy Jenkins master and agent servers on AWS EC2 using Terraform.

## Quick Start

1. **Setup**:
   ```bash
   aws configure
   ssh-keygen -t rsa -b 2048 -f id_rsa
   terraform init
   ```

2. **Deploy infrastructure**:
   ```bash
   terraform apply
   ```

## Jenkins Master-Agent Setup

### 1. Access Jenkins Master
- SSH into master server: `ssh -i id_rsa ubuntu@<master_ip>`
- Access Jenkins UI: `http://<master_ip>:8080`
- Get initial admin password: `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

### 2. Connect Agent to Master
1. In Jenkins UI: **Manage Jenkins** → **Manage Nodes** → **New Node**
2. Create agent node with SSH connection
3. Use agent server private IP and SSH key for connection
4. Agent will automatically connect to master

## Key Variables
- `server_count` - Number of servers (default: 1)
- `enable_elastic_ip` - Enable Elastic IPs (default: false)
- `region` - AWS region (default: us-east-1)

## Outputs
- `server_public_ips` - Public IP addresses
- `server_elastic_ips` - Elastic IP addresses (when enabled)

## Cleanup
```bash
terraform destroy
```