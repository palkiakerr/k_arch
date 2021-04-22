#!/bin/sh

echo "This is Kerr's ArchLinux Installer, DO NOT use this unless you have previously modified the script for your partition scheme"
echo "Current Partition Scheme: Full-size root, no swap"

timedatectl set-ntp true

# Partitioning for DOS sys, code ripped from stackoverflow
(
echo g
echo n # Add a new partition
echo 1 # Primary partition
echo   # Start Sector
echo +550M  # End sector
echo t # Change Type
echo 1 # To EFI system

echo n
echo 2
echo
echo

echo w # Write changes
echo q
) | fdisk /dev/sda

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt


pacstrap /mnt base base-devel linux linux-firmware


# Configuration
genfstab -U /mnt >> /mnt/etc/fstab

# Move post-chroot script
mv k_arch/post_chroot.sh /mnt/post_chroot.sh
mv k_arch/setup_kerr_workenv.sh /mnt/setup_kerr_workenv.sh
arch-chroot /mnt ./post_chroot.sh