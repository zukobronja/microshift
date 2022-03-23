#!/bin/bash

#title           : bootstrap.sh
#description     : Deploys crio, microshift and clients
#author		     : Zuko Bronja

# echo "Update VM"
# sudo dnf update -y

echo "install crio"
sudo dnf module enable -y cri-o:1.21
sudo dnf install -y cri-o cri-tools
sudo systemctl enable crio --now


echo "install microshift"
sudo dnf copr enable -y @redhat-et/microshift
sudo dnf install -y microshift
sudo firewall-cmd --zone=trusted --add-source=10.42.0.0/16 --permanent
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5353/udp --permanent
sudo firewall-cmd --reload
sudo systemctl enable microshift --now


echo "install OpenShift Client"
curl -O https://mirror.openshift.com/pub/openshift-v4/$(uname -m)/clients/ocp/stable/openshift-client-linux.tar.gz
sudo tar -xf openshift-client-linux.tar.gz -C /usr/local/bin oc kubectl

sleep 2m 

echo "Copy Kubeconfig"
mkdir ~/.kube
sudo cat /var/lib/microshift/resources/kubeadmin/kubeconfig > ~/.kube/config

echo "kubecconfig ..."
sudo cat /var/lib/microshift/resources/kubeadmin/kubeconfig

echo "\n......................................................................"

sleep 5

echo "Show Pods"
oc get pods -A
