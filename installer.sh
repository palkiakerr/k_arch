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
) | fdisk

mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt


pacstrap /mnt base linux linux-firmware