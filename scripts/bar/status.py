from pathlib import Path
from datetime import datetime
import re

## Dzen2 Bar with Python
## To Run in Linux:
## $ killall dzen2 | while :;do python3.5 status.py; sleep 1;done | dzen2 -p -e "button3="

## Icon Path
icons = "/home/kleber/scripts/icons"

## Memmory Status
with open("/proc/meminfo") as fileOpen: MemFile = fileOpen.read()
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
memTotal = float(memTotal/1024/1024)

if int(memUsed/1024) > 1024: memUsed, suffix = float(memUsed/1024/1024), "G"
else: memUsed, suffix = memUsed, "MiB"

## Os Status
with open("/etc/os-release") as fileOpen: OsFile = fileOpen.read()
fileOpen.closed

os = re.search("^NAME=.*\n", OsFile)
os = re.sub("NAME=|\"", "", os.group(0)).strip("\n")

## Kernel Status
with open("/proc/cmdline") as fileOpen: KernelFile = fileOpen.read()
fileOpen.closed

kernel = re.search("BOOT_IMAGE=.*? ", KernelFile)
kernel = re.sub(".*?vmlinuz-|\s", "", kernel.group(0))

## Data & Time Status
now = datetime.now()

hour = now.hour

if hour <= 11: timeStatus = now.strftime("%I:%M DM")
elif hour >= 12 and hour <= 17: timeStatus = now.strftime("%I:%M DT")
else: timeStatus = now.strftime("%I:%M DN")

## Packages
if Path("/usr/bin/apt").exists():
    with open("/var/lib/dpkg/status") as fileOpen: packagesFile = fileOpen.read()
    fileOpen.closed

    packages = len(re.findall("Status: install ok installed", packagesFile)) ## Debian's

if Path("/usr/bin/emerge").exists(): packages = len(Path("/var/db/pkg").glob("*/*")) ## Gentoo's

## Final Print
print("^fg(#ff0000) ^i({}/Gentoo.xbm)^fg() {}".format(icons, kernel),
      "^fg(#ff0000) ^i({}/Mem.xbm)^fg() {:0.1f}{} / {:0.1f}G".format(icons, memUsed, suffix, memTotal),
      "^fg(#ff0000) ^i({}/Packages.xbm)^fg() {}".format(icons, packages),
      "^fg(#ff0000) ^i({}/User.xbm)^fg() {}".format(icons, os),
      "^fg(#ff0000) ^i({}/Relogio.xbm)^fg() {}".format(icons, timeStatus))
