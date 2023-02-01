##
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1 
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

##
sudo yum clean all && sudo yum -y makecache
sudo yum -y install epel-release vim git curl wget kubelet kubeadm kubectl --disableexcludes=kubernetes


##
kubeadm version
kubectl version --client


##
sudo setenforce 0
sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

##
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a


#### CONTAINERD
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

# Load at runtime
sudo modprobe overlay
sudo modprobe br_netfilter

# Ensure sysctl params are set
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload configs
sudo sysctl --system
# Install required packages
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Verifier br_netfilter
lsmod | grep br_netfilter
sudo systemctl enable kubelet 

##
sudo rm \u2013rf /etc/containerd/config.toml
sudo systemctl restart containerd
# Install containerd
sudo yum install -y containerd.io
# Configure containerd and start service
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
# restart containerd
sudo systemctl disable docker
sudo systemctl stop docker
sudo systemctl restart containerd
sudo systemctl enable containerd
#####
