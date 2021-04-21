#!/bin/sh

echo "This is Kerr's ArchLinux Installer, DO NOT use this unless you have previously modified the script for your partition scheme"
echo "Current Partition Scheme: Full-size root, no swap"

timedatectl set-ntp true

# Partitioning for DOS sys, code ripped from stackoverflow
(
echo o
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | fdisk /dev/sda

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt


pacstrap /mnt base linux linux-firmware


# Configuration
genfstab -U /mnt >> /mnt/etc/fstab

# Move post-chroot script
mv k_arch/post_chroot.sh /mnt/post_chroot.sh
arch-chroot /mnt