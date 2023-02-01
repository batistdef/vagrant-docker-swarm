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
vagrant up
```

### Créer un fichier docker_config.json qui contient le login à docker hub:
Pour le generer il faut lancer `docker login` et copier le contenu du fichier dans un fichier nommé `docker_login.json` à la racine du projet

### Ensuite pour connecter les machines entre elles:
```ssh
vagrant ssh manager
[vagrant@manager ~]$ docker swarm init --advertise-addr 192.168.208.128
```



----------


*Pour utiliser kvm/libvirt/qemu il y a la branche kvm de disponible.
