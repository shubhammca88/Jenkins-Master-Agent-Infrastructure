#!/bin/bash
apt update -y
apt install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
apt update -y
apt install -y jenkins
systemctl enable jenkins
systemctl start jenkins