# Backup-script for small-flash routerboard models

This script for RouterOS 7 is useful for creating backups on connected flash devices, regardless of their mount point.

## Main Description

This script is designed for routers with limited flash storage. I use an hAP ac2 with a USB flash drive connected via a USB hub, as an LTE modem is connected to another port. If I switch the USB flash drive to a different port on the hub, the mount point changes as well. This script scans all mounted block devices for an existing "backup" folder and uses this folder to create backup files in subfolders named with a timestamp.

Tested on hAP ac2 with RouterOS 7.18.2.

[This](https://forum.mikrotik.com/viewtopic.php?t=10278) topic was used as inspiration

## Known bugs

Sometimes is something wrong when mount point name in ```/disk print where mounted``` already has a "backup" folder. Maybe it's just a codepage problem. So it need to recreate this folder using RouterOS.
