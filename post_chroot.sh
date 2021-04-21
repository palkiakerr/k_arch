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

pacman -S grub efibootmgr dosfstools os-prober mtools --noconfirm
mkdir /boot/EFI
mount /dev/sda1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg