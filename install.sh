#!/bin/bash

# Juju SETUP (https://jujucharms.com/docs/2.0/getting-started)
# Created by: Breno Polanski <breno.polanski@gmail.com>

zenity --info --title "Juju SETUP" --text "This is a simple script for installing Juju tools on Ubuntu environment. \n\nCreated by: Breno Polanski <breno.polanski@gmail.com>"

answer=$(zenity  --list  --text "Choose the packages you want to install." --checklist  --column "Install" --column "Id" --column "Package" --column "Description"\
  TRUE "1" "Juju" ""\
  TRUE "2" "LXD" "A hypervisor for LXC, providing fast, secure containers."\
  TRUE "3" "ZFS Utils" "A highly efficient and feature-rich filesystem and logical volume manager."\
  TRUE "4" "Charm Tools" "The Charm Tools Juju Plugin is a collection of commands enabling users and charm authors to create, search, fetch, update, and manage charms."\
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
  sudo apt-get -y install lxd
  sudo newgrp lxd
  sudo lxd init
fi

if [[ $answer =~ "4" ]]; then
  sudo apt-get -y install charm-tools
fi

# Clean up
sudo apt-get -y autoclean

# Removing unnecessary packages
sudo apt-get -y autoremove

zenity --info --title "Installation finished" --text "Installation finished successfully!"
