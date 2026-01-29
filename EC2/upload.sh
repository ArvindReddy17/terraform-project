#!/bin/bash

dnf update -y

# Install Java
dnf install java-17-amazon-corretto -y

# Add Jenkins repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
dnf install jenkins -y

# Start Jenkins
systemctl enable jenkins
systemctl start jenkins
