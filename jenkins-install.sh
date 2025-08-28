#!/bin/bash
# Jenkins Installation Script for Ubuntu EC2
# Tested on Ubuntu 20.04/22.04

set -e

echo "===== Updating system ====="
sudo apt update -y && sudo apt upgrade -y

echo "===== Installing Java (OpenJDK 17) ====="
sudo apt install -y openjdk-17-jdk
java -version

echo "===== Adding Jenkins repo and key ====="
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "===== Updating package list ====="
sudo apt update -y

echo "===== Installing Jenkins ====="
sudo apt install -y jenkins

echo "===== Enabling and starting Jenkins ====="
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "===== Checking Jenkins status ====="
sudo systemctl status jenkins --no-pager

echo "===== Jenkins initial admin password ====="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "===== Installation complete! ====="
echo "Open Jenkins in your browser: http://<your-ec2-public-ip>:8080"
