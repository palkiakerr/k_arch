REM Spins up a test vm from which to test archlinux installs
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" unregistervm --delete "C:\Users\mxwke\VirtualBox VMs\archtest\archtest.vbox"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createvm --name archtest --basefolder "C:\Users\mxwke\VirtualBox VMs" --ostype ArchLinux_64 --default --register
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "C:\Users\mxwke\VirtualBox VMs\archtest\archtest.vbox" --firmware efi64 --nic1 bridged --bridgeadapter1 "Intel(R) Wireless-AC 9560 160MHz"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach archtest --storagectl IDE --port 1 --device 0 --type dvddrive  --medium "C:\Users\mxwke\Downloads\archlinux.iso"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm archtest

REM see https://github.com/myspaghetti/virtualbox-scancodes for scancode interface help

timeout 3
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm archtest keyboardputscancode 1C 9C