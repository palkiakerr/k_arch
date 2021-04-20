#!/bin/sh

Echo "This is Kerr's ArchLinux Installer, DO NOT use this unless you have previously modified the script for your partition scheme"
Echo "Current Partition Scheme: Full-size root, no swap"

timedatectl set-ntp true

# Partitioning for DOS sys, code ripped from stackoverflow
(
echo o # Create a new empty DOS partition table
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
arch-chroot /mnt

# GB time
ls -sf /usr/share/zoneinfo/GB/GB /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=en_GB.UFT-8" > /etc/locale.conf
echo "/usr/share/kbd/keymaps/i386/qwerty/uk.map.gz" > /etc/vconsole.conf

# Networking Conf
read hstnm
echo $hstnm > /etc/hostname
echo "127.0.0.1	localhost"
echo "::1		localhost"
echo "127.0.1.1	$myhostname.localdomain	$myhostname"