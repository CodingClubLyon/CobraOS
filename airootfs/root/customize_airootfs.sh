#!/bin/bash

echo -e "\n\n#####################################\n#   STARTING CUSTOMIZATION SCRIPT   #\n#####################################\n\n"

set -e -u

sed -Ei 's/#((en_US|fr_FR)\.UTF-8)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Create and configure users
usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

useradd -mUG wheel -s /usr/bin/zsh student

if [ -f "/root/passwords" ]; then
    chpasswd < /root/passwords
    rm /root/passwords
else
    echo -e "\n##### WARNING #####\n/root/passwords was not provided!\n No root access will be possible!\n"
fi

# Allow the wheel group to use sudo
sed -i 's/# \(%wheel ALL=(ALL) ALL\)/\1/' /etc/sudoers

# Enable all pacman servers
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

# Set journald storage to volatile
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

# Disable power keys
sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

systemctl set-default multi-user.target
systemctl enable pacman-init.service choose-mirror.service nodm.service hostname.service NetworkManager.service

echo -e "\n\n#####################################\n#     CUSTOMIZATION SCRIPT DONE     #\n#####################################\n\n"
