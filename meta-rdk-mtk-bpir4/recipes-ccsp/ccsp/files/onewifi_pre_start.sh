#!/bin/sh

iw phy phy0 interface add wifi0 type __ap
iw phy phy0 interface add wifi1 type __ap
iw phy phy0 interface add wifi2 type __ap

#Obtain the wifi0 mac address
wifi0_mac="$(cat /sys/class/ieee80211/phy0/macaddress)"
#Strip the : and increment mac by 1 to get wifi1 macaddress
mac=$(echo $wifi0_mac | tr -d ':')
mac_incr=$((0x$mac + 1))
wifi1_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
#Increment again by 1 to get wifi2 address
mac_incr=$(($mac_incr + 1))
wifi2_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
#print the mac address
echo $wifi0_mac
echo $wifi1_mac
echo $wifi2_mac

#Update the mac address using ip link command
ifconfig wifi0 down
ifconfig wifi1 down
ifconfig wifi2 down
ip link set dev wifi0 address $wifi0_mac
ip link set dev wifi1 address $wifi1_mac
ip link set dev wifi2 address $wifi2_mac
ifconfig wifi0 up
ifconfig wifi1 up
ifconfig wifi2 up

exit 0
