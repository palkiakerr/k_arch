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