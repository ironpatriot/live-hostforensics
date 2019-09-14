# Simple Volalitile Artficact Collector in Powershell

## High level objectives

1. Create list of areas the are forensically important/volitile

2. Read from those areas

3. Write it to a text file

4. For each operation
    - Timestamp the file
    - Hash the file

## Things to collect

operating system
hardware list
software list
accounts/users
network
mapped drives
usb devices
network shares
file listing

live registry**

process hashing
hidden processes
dlls loaded / on system
current logged on user

sfc /scannow
log files
timestamp operations and report
