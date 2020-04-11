#!/usr/bin/env bash

#system tools xorg, audio, daemons, etc
sudo pacman -S xorg --ignore xorg-server-xdmx
sudo pacman -S xorg-drivers xorg-xinit

sudo pacman -S alsa-utils #apulse

sudo pacman -S freetype2 apparmor gst-libav xdg-utils gconf wget curl chrony

#setup graphics drivers
sudo pacman -S mesa

sh ~/.local/installers/suckless-install.sh
