#!/bin/sh

# GB time
ln -sf /usr/share/zoneinfo/GB /etc/localtime
hwclock --systohc   
locale-gen
echo "LANG=en_GB.UFT-8" > /etc/locale.conf
echo "/usr/share/kbd/keymaps/i386/qwerty/uk.map.gz" > /etc/vconsole.conf

# Networking Conf

echo "slant" > /etc/hostname
echo "127.0.0.1	localhost" > /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	slant.localdomain	slant" >> /etc/hosts

pacman -S grub efibootmgr dosfstools os-prober mtools networkmanager git sudo --noconfirm
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
clear

# User Stuff
echo "Adding user kerr"
useradd -m kerr
usermod -aG wheel,audio,video,optical,storage kerr
mv setup_kerr_workenv.sh /home/kerr/setup_kerr_workenv.sh
echo "Please set a both user passwords before rebooting!"
echo "Please enable sudo access for kerr with visudo before rebooting"
rm post_chroot.sh