#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo apt-get update
sudo apt-get install openjdk-8-jre openjdk-8-jdk -y
sudo apt-get wget
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y
