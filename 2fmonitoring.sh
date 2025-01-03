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

wall "	#Architecture: $name
	#CPU physical: $phyp
	#vCPU: $virp
	#Memory Usage: $memu
	#Disk Usage: $disk
	#CPU load: $cpul
	#Last boot: $boot
	#LVM use: $lvmu
	#Connections TCP: $tcpc ESTABLISHED
	#User log: $user
	#Network: IP $ipv4($maca)
	#Sudo: $sudo cmd"
