#!/bin/bash

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

sudo lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
sudo chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
sudo chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
sudo lsattr /etc/passwd /etc/shadow >/dev/null 2>&1

read -p "设置root密码:" password
echo root:$password | sudo chpasswd root
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
sudo service sshd restart
green "VPS用户名：root"
green "vps密码：$password"
echo "请妥善保存好登录信息！"
