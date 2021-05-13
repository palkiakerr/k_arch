#!/bin/sh

# Drivers and X11 packages
# Work out what compositor (if any to add to below command)
pacman -Syyu --noconfirm
pacman -S xf86-video-vesa xf86-video-intel xf86-video-fbdev xorg xorg-xinit nitrogen --noconfirm

# Set up AUR support via yay
#git clone https://aur.archlinux.org/yay-git.git
#cd /home/kerr/yay-git
#makepkg -si --noconfirm
#cd


# Setting up i3
pacman -S xorg-server xorg-xinit libx11 libxinerama libxft webkit2gtk nitrogen --noconfirm



# Set bash_profile to xinit
echo "startx" >> .bash_profile
echo "exec i3" > .xinitrc

# Download all the software I like to use
#pacman -S brave newsboat tlp blender virtualbox
systemctl enable tlp.service


rm ~/setup_kerr_workenv.sh
