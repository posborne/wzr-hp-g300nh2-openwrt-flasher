#!/bin/bash -x
#
# See Readme.md for details.  You may need to change
# some of the constants defined in this script.  Made
# to work with mac/unix utilizing curl.
#

# Yours may be different (e.g. eth0)
NETWORK_INTERFACE="eth0"

# must be changed for G300H versus G300-NH2
MAC_ADDRESS="02-AA-BB-CC-DD-1A"

# Your name may be different (store in same directory)
FW="openwrt-ar71xx-generic-wzr-hp-g300nh2-squashfs-tftp.bin"

function setup_networking() {
    echo "Setting up network adapter"
    ifconfig $NETWORK_INTERFACE 192.168.11.2
    arp -s 192.168.11.1 $MAC_ADDRESS
}

function attempt_flash() {
    #vecho "Plugin router and hit enter (or vice versa)"
    # read input
    echo "Attempting to flash firmware"
    # OR $ tftp 192.168.11.1 -c put $FW
    curl -T $FW tftp://192.168.11.1
    #echo "put $FW" | tftp 192.168.11.1
    echo "Complete; check router LEDs"
    echo "Solid RED is bad.  Fast blink is flashing"
    echo "If good: http://wiki.openwrt.org/doc/howto/firstlogin"
}

setup_networking
attempt_flash
