# Docker Swarm 1 Manager 2 Workers
## Avec Vagrant et Ansible

Il faut virtualbox et vagrant sur la machine hôte.*

### Pour installer vagrant sur CentOS 7:
```sh
wget https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_x86_64.rpm
sudo yum localinstall vagrant_2.2.2_x86_64.rpm
```

### Pour utiliser ce repository:
```sh
git clone https://github.com/batistdef/vagrant-docker-swarm.git
cd vagrant-docker-swarm
# Optionnel: par défaut les ressources des VMs sont limitées, pour les augmenter comme dans le TP:
cp -f hosts.default.yml hosts.yml
vagrant up
```

### Créer un fichier docker_config.json qui contient le login à docker hub:
Pour le generer il faut lancer `docker login` et copier le contenu du fichier dans un fichier nommé `docker_config.json` à la racine du projet

### Ensuite pour connecter les machines entre elles il faudra récupérer ces lignes dans le log de la machine manager:
```sh
You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join manager:6443 --token y814xr.v8pnccnd5o7awha7 \
	--discovery-token-ca-cert-hash sha256:e6db568b47c4970448282155c2dadc6718f052e28bc95bbdf542f8e3e1d2cea5 \
	--control-plane --certificate-key 11384c59233f731ee7f2a689b6971d16510e8d8061e2f4685795a28e9c910ac7

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join manager:6443 --token y814xr.v8pnccnd5o7awha7 \
	--discovery-token-ca-cert-hash sha256:e6db568b47c4970448282155c2dadc6718f052e28bc95bbdf542f8e3e1d2cea5
```
### Puis lancer manuellement sur chacun des worker la commande:
```sh
kubeadm join manager:6443 --token y814xr.v8pnccnd5o7awha7 \
	--discovery-token-ca-cert-hash sha256:e6db568b47c4970448282155c2dadc6718f052e28bc95bbdf542f8e3e1d2cea5
```


----------


*Pour utiliser kvm/libvirt/qemu il y a la branche kvm de disponible.
