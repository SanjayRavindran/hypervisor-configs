#!/bin/bash

## -----===== Start of bash =====-----
	printf '\033[8;40;75t'		# will resize the window, if needed.
echo -------------------------========================-------------------------
## Software lead in
	start=$SECONDS
	now=$(date +"%Y-%m-%d_%A_%I:%M:%S")
	echo "Current time : $now"
echo -------------------------========================-------------------------
echo "ProxMox Setup script"
echo ------
sleep 0.25

rm /etc/apt/sources.list.d/pve-enterprise.list
truncate -s 0 /etc/apt/sources.list
echo “deb http://ftp.debian.org/debian bullseye main contrib non-free” > /etc/apt/sources.list
echo “deb http://ftp.debian.org/debian bullseye-updates main contrib non-free” > /etc/apt/sources.list

echo “deb http://security.debian.org bullseye-security main contrib non-free” > /etc/apt/sources.list

echo “deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription” > /etc/apt/sources.list

apt update && apt upgrade -y

sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

bash <(curl -s https://raw.githubusercontent.com/Weilbyte/PVEDiscordDark/master/PVEDiscordDark.sh ) install

apt install sudo git ffmpeg intel-opencl-icd -y

echo "reboot to see the changes made"
