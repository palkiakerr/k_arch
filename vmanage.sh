#!/bin/sh
VMPATH="${VMPATH:-"$HOME/virtual"}"



# Script to manage my personal virtual machines
# Assumes virtualbox VMs are in $VIRTUALPATH and
# the corresponding file structure has been created
# by the startup command


# Define image names and their download addresses
# need to make updateable
archlinux="http://mirrors.evowise.com/archlinux/iso/2021.04.01/archlinux-2021.04.01-x86_64.iso"
debian="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.9.0-amd64-netinst.iso"
qubes="https://mirrors.edge.kernel.org/qubes/iso/Qubes-R4.0.4-x86_64.iso"
manjaro="https://download.manjaro.org/xfce/21.0.2/manjaro-xfce-21.0.2-210419-linux510.iso"
kali="https://cdimage.kali.org/kali-2021.1/kali-linux-2021.1-live-amd64.iso"





# Sets up directory structure
if [ "$1" == "setup" ]
then
    echo "Make sure you have set VMPATH, else default to ~/virtual"
    mkdir -p $VMPATH $VMPATH/iso/default $VMPATH/machines
    exit 0
fi


# Download commonly used ISOs, download addressed defined manually above
# To-DO, pull ISOs from a .config, add auto key verification?
if [ "$1" == "download" ]
then

    if [ "$2" == "all" ]
    then
        rm ~/documents/iso/default/*.iso
        wget $archlinux $debian $qubes $manjaro $kali
        echo "Downloads Complete! The currently available ISOs are"
        ls $VMPATH/iso/default/*.iso
    fi

    if [ "$2" == "archlinux" ]
    then
        echo "Refreshing ISO for $2"
        ls $VMPATH/iso/default/archlinux*.iso
        wget $archlinux
    fi

    if [ "$2" == "debian" ]
    then
        echo "Refreshing ISO for $2"
        ls $VMPATH/iso/default/debian*.iso
        wget $debian
    fi

    if [ "$2" == "qubes" ]
    then
        echo "Refreshing ISO for $2"
        ls $VMPATH/iso/default/qubes*.iso
        wget $qubes
    fi

    if [ "$2" == "kali" ]
    then
        echo "Refreshing ISO for $2"
        ls $VMPATH/iso/default/kali*.iso
        wget $kali
    fi

    if [ "$2" == "manjaro" ]
    then
        echo "Refreshing ISO for $2"
        ls $VMPATH/iso/default/manjaro*.iso
        wget $manjaro
    fi
fi


# Comands for creating a "fresh" vm with the default 2 GB ram and 15 Gb hdd
# first checks if the ISO exists, always deletes the previous default fresh vm
if [ $1 == "fresh" ] #&& -n "$(ls $VMPATH/iso/default/$2*.iso)" ]
then
    VBoxManage unregistervm --delete "$2-default"
    VBoxManage createvm --name "$2-default" --basefolder $VMPATH/machines --ostype ArchLinux_64 --default --register
    VBoxManage "$2-default" --memory 2048 --cpus  1
    VBoxManage modifyhd $VMPATH/machines/$2-default/$2-default.vdi --resize 15000
    VBoxManage storageattach $2-default --storagectl IDE --port 1 --device 0 --type dvddrive  --medium $($VMPATH/iso/default/$2.iso)
    VBoxManage startvm archtest
else
    echo "Error: Can't find ISO"
    echo "Debug: ISO search for $2 returns $(ls $VMPATH/iso/default/$2*.iso)"
fi
