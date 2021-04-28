#!/bin/sh

# Script to obtain, verify and deploy a Qubes virtual machine.
#
# To be used for darkweb expolration / cleaning suspected
# infected files

REM Spins up a test vm from which to test archlinux installs
vboxmanage unregistervm --delete securebox
vboxmanage createvm --name archtest --ostype ArchLinux_64 --default --register
vboxmanage modifyvm "C:\Users\mxwke\VirtualBox VMs\archtest\archtest.vbox" --firmware efi64 --nic1 bridged --bridgeadapter1 "Intel(R) Wireless-AC 9560 160MHz"
vboxmanage storageattach archtest --storagectl IDE --port 1 --device 0 --type dvddrive  --medium "C:\Users\mxwke\Downloads\archlinux.iso"
vboxmanage startvm securebox