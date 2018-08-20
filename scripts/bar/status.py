from datetime import datetime
import re

## Dzen2 Bar with Python
## To Run in Linux:
## $ killall dzen2 | while :;do python3.5 status.py; sleep 1;done | dzen2 -p -e "button3="

## Memmory Status
with open("/proc/meminfo") as fileOpen:
    MemFile = fileOpen.read()

fileOpen.closed

memTotal = re.search("MemTotal:.*\n", MemFile)
memFree = re.search("MemFree:.*\n", MemFile)
buffers = re.search("Buffers:.*\n", MemFile)
cached = re.search("Cached:.*\n", MemFile)
slab = re.search("Slab:.*\n", MemFile)

memTotal = int(re.sub("[^0-9]", "", memTotal.group(0)))
memFree = int(re.sub("[^0-9]", "", memFree.group(0)))
buffers = int(re.sub("[^0-9]", "", buffers.group(0)))
cached = int(re.sub("[^0-9]", "", cached.group(0)))
slab = int(re.sub("[^0-9]", "", slab.group(0)))

memUsed = memTotal - memFree - buffers - cached - slab

## Os Status
with open("/etc/os-release") as fileOpen:
    OsFile = fileOpen.read()

fileOpen.closed

os = re.search("^NAME=.*\n", OsFile)
os = re.sub("NAME=|\"", "", os.group(0)).strip("\n")

## Kernel Status
with open("/proc/cmdline") as fileOpen:
    KernelFile = fileOpen.read()

fileOpen.closed

kernel = re.search("BOOT_IMAGE=.*? ", KernelFile)
kernel = re.sub(".*?vmlinuz-", "", kernel.group(0))

## Data & Time Status
now = datetime.now()

hour = now.hour

if hour <= 11:
    timeStatus = now.strftime("%I:%M DM")
elif hour >= 12 and hour <= 17:
    timeStatus = now.strftime("%I:%M DT")
else:
    timeStatus = now.strftime("%I:%M DN")

## Packages
with open("/var/lib/dpkg/status") as fileOpen:
    packagesFile = fileOpen.read()

fileOpen.closed

packages = re.findall("Status: install ok installed", packagesFile)

## Final Print
print("^fg(#ff0000) ^i(/home/kleber/scripts/icons/Mem.xbm)^fg()", int(memTotal/1024), "MiB /", int(memUsed/1024), "MiB",
      "^fg(#ff0000) ^i(/home/kleber/scripts/icons/User.xbm)^fg()", os,
      "^fg(#ff0000) ^i(/home/kleber/scripts/icons/Packages.xbm)^fg()", len(packages),
      "^fg(#ff0000) ^i(/home/kleber/scripts/icons/Gentoo.xbm)^fg()", kernel,
      "^fg(#ff0000) ^i(/home/kleber/scripts/icons/Relogio.xbm)^fg()", timeStatus)
