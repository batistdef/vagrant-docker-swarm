echo "100.0.0.10 manager.k8s.local" | sudo tee -a /etc/hosts

sudo kubeadm config images pull

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --upload-certs --apiserver-advertise-address=100.0.0.10 #--control-plane-endpoint=manager.k8s.local 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl cluster-info
kubectl get nodes

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

kubectl get pods --all-namespaces
kubectl get nodes -o wide