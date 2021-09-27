#!/bin/bash
sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo apt-get install curl -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo touch /etc/apt/sources.list.d/kubernetes.list
sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
#echo "The page was created by the user-data" | sudo tee /var/www/html/index.html
#cat <<EOF >/etc/apt/sources.list.d/kubernetes.list  deb http://apt.kubernetes.io/ kubernetes-xenial main  EOF
sudo apt-get update
sudo apt-get install -y kubelet=1.15.4-00 kubeadm=1.15.4-00 kubectl=1.15.4-00 docker.io
kubeadm init
