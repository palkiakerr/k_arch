#!/bin/sh

echo "to-do:  setup base customisation, 1st priority is dwm/xorg?"
#set up AUR suport (yay)

# Drivers and X11 packages
# Work out what compositor (if any to add to below command)
pacman -Syyu --noconfirm
pacman -S xf86-video-vesa xf86-video-intel xf86-video-fbdev xorg xorg-xinit nitrogen --noconfirm

# Set up AUR support via yay
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si --noconfirm


# Setting up suckless
pacman -S xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk nitrogen --noconfirm
git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/st
git clone https://git.suckless.org/dmenu
echo "exec dwm" >> .xinit
cd streboot
make clean install
cd ../dwm
make clean install
cd ..
# watch current working directory if you change this!
# TODO change DWM config to make st default terminal


# Set bash_profile to xinit
echo "startx" >> .bash_profile
echo "exec dwm" > .xinitrc

rm setup_kerr_workenv.sh