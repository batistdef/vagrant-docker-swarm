#!/bin/sh

mkdir /home/vagrant/.docker/
cp /vagrant/docker_config.json /home/vagrant/.docker/config.json
chown -R vagrant: /home/vagrant/.docker
sudo -u vagrant docker login
