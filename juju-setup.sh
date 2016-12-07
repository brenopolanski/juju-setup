#!/bin/bash

# Juju SETUP (https://jujucharms.com/docs/2.0/getting-started)
# Created by: Breno Polanski <breno.polanski@gmail.com>

zenity --info --title "Juju SETUP" --text "This is a simple script for installing Juju tools on Ubuntu environment. \n\nCreated by: Breno Polanski <breno.polanski@gmail.com>"

answer=$(zenity  --list  --text "Choose the packages you want to install." --checklist  --column "Install" --column "Id" --column "Package" --column "Description"\
  FALSE "1" "Juju" ""\
  FALSE "2" "LXD" "A hypervisor for LXC, providing fast, secure containers."\
  FALSE "3" "ZFS Utils" "A highly efficient and feature-rich filesystem and logical volume manager."\
  FALSE "4" "Create Juju environment variables" ""\
  FALSE "5" "Charm Tools" "The Charm Tools Juju Plugin is a collection of commands enabling users and charm authors to create, search, fetch, update, and manage charms."\
  FALSE "6" "Juju Plugins" "Collection of plugins created by various authors to make using Juju easier."\
  --separator=":" --width=750 --height=700)

if [[ $answer =~ "1" ]]; then
  # add repository
  sudo add-apt-repository -u ppa:juju/stable
  sudo apt-get update
  sudo apt-get -y install juju
fi

if [[ $answer =~ "2" ]]; then
  sudo apt-get -y install zfsutils-linux
fi

if [[ $answer =~ "3" ]]; then
  sudo apt-get -y install lxd
  sudo newgrp lxd
  sudo lxd init
fi

if [[ $answer =~ "4" ]]; then
  echo 'export JUJU_REPOSITORY=/home/juju/charms' >> ~/.bashrc
  echo 'export LAYER_PATH=$JUJU_REPOSITORY/layers' >> ~/.bashrc
  echo 'export INTERFACE_PATH=$JUJU_REPOSITORY/interfaces' >> ~/.bashrc
fi

if [[ $answer =~ "5" ]]; then
  sudo apt-get -y install charm-tools
fi

if [[ $answer =~ "6" ]]; then
  sudo apt-get -y install git python-jujuclient
  sudo git clone https://github.com/juju/plugins.git ~/.juju-plugins
  echo 'PATH=$PATH:$HOME/.juju-plugins' >> ~/.bash_profile
  source ~/.bash_profile
fi

# Clean up
sudo apt-get -y autoclean

# Removing unnecessary packages
sudo apt-get -y autoremove

zenity --info --title "Installation finished" --text "Installation finished successfully!"
