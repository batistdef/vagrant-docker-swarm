#!/bin/sh

mkdir /home/vagrant/.docker/ /root/.docker
cp /vagrant/docker_config.json /home/vagrant/.docker/config.json
cp /vagrant/docker_config.json /root/.docker/config.json
chown -R vagrant: /home/vagrant/.docker
echo "DOCKER LOGIN FOR vagrant"
sudo -u vagrant docker login
echo "DOCKER LOGIN FOR root"
docker login
