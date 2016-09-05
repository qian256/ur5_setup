#!/bin/sh
# 
# file   urmagic_upload_programs.sh
# author Anders Dubgaard <and@universal-robots.com>
#  
# Script to upload programs to robot from USB stick
# 

LOGGER="/usr/bin/logger"
TAG="-t '$(basename $0)'"

if [ "$1" = "" ] ; then
    $LOGGER -p user.info $TAG "$0: no mountpoint supplied, exiting."
    exit 1 ; fi

MOUNTPOINT="$1"
DEST=("/programs")

copy_files() {
  $LOGGER -p user.info $TAG "$0: copying files from $MOUNTPOINT to $DEST..."

  list=$(mktemp)

  cd $MOUNTPOINT
  find . | grep -E '\.(urp|script|installation|variables|vars|txt)$' | cpio -vdump --quiet $DEST &> $list

  $LOGGER -p user.info $TAG -f $list
  $LOGGER -p user.info $TAG "$0: ...copy done."

  # Make sure data is written to the USB key
  sync
  sync
}

# Warn user not to remove USB key
echo "! USB !" | DISPLAY=:0 aosd_cat -R red -x 230 -y -210 -n "Arial Black 80"

copy_files

# Notify user it is ok to remove USB key
echo "<- USB" | DISPLAY=:0 aosd_cat -x 200 -y -210 -n "Arial Black 80"
