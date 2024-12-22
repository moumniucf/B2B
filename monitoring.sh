#!/bin/bash

name=$(uname -a)
phyp=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
virp=$(cat /proc/cpuinfo | grep "processor" | wc -l)
memu=$(free --mega | awk '/Mem/{printf("%.f/%.fMB (%.2f%%)", $3, $2, $3/$2*100)}')
disk=$(df -h / | awk '/dev/{printf("%.1f/%.1fGb (%.f%%)", $3, $2, $3/$2*100)}')
cpul=$(top -bn1 | grep %Cpu | awk '{print $4"%"}')
boot=$(who -b | awk '{print $3" "$4}')
lvmu=$(lsblk | grep lvm | wc -l | awk '{printf($1==0?"no":"yes")}')
tcpc=$(netstat -an | grep ESTABLISHED | wc -l)
user=$(who | cut -d " " -f1 | sort -u | wc -l)
ipv4=$(hostname -I)
maca=$(ip a | grep ether | awk '{print $2}')
sudo=$(journalctl _COMM=sudo -q | grep COMMAND | wc -l)

echo "#Architecture: $name"
echo "#CPU physical: $phyp"
echo "#vCPU: $virp"
echo "#Memory Usage: $memu"
echo "#Disk Usage: $disk"
echo "#CPU load: $cpul"
echo "#Last boot: $boot"
echo "#LVM use: $lvmu"
echo "#Connections TCP: $tcpc ESTABLISHED"
echo "#User log: $user"
echo "#Network: IP $ipv4($maca)"
echo "#Sudo: $sudo cmd"
