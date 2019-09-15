# Simple Volatile Artficact Collector in Powershell

## Dependencies

- Run Script as Admin
- Requires Powershell 5 or later. Not tested on Powershell < 5

## High level objectives

1. Create list of areas the are forensically important/volitile

2. Read from those areas

3. Write it to a text file - Not Complete

4. For each operation
    - Timestamp the file - Not Complete
    - Hash the file - Not Complete

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
