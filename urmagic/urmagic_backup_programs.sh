#!/bin/sh
# 
# file   urmagic_backup_programs.sh
# author Frederik Ellehoej <fke@universal-robots.com>
#  
# Script to backup programs from robot
# 

LOGGER="/usr/bin/logger"

if [ "$1" = "" ] ; then
    $LOGGER -p user.info "$0: no mountpoint supplied, exiting."
    exit 1 ; fi

MOUNTPOINT="$1"
SERIALNO_FILE="/root/ur-serial"
SRC_DIR='/programs'

# Warn user not to remove USB key
echo "! USB !" | DISPLAY=:0 aosd_cat -R red -x 230 -y -210 -n "Arial Black 80"

# Find the serial number of the robot
if [ -e "$SERIALNO_FILE" ]; then
    SERIALNO=`head -n1 $SERIALNO_FILE`
    if [ -z $SERIALNO ]; then
	      SERIALNO="no-serial-no-found"
    fi
else
	SERIALNO="no-serial-no-found"    
fi

DATADIR="$SERIALNO"
DATAPATH="$MOUNTPOINT/$DATADIR"

# Find a name for the library on the USB key (based on the serial number) to copy the data to
CNT=0
while [ -e "$DATAPATH" ]; do
	DATAPATH="${MOUNTPOINT}/${DATADIR}_${CNT}"
	let CNT+=1			
done 
mkdir -p $DATAPATH
$LOGGER -p user.info "$0: using datapath: $DATAPATH"    

# tmpfile for list of copied files
list=$(mktemp)

# copy files
cd $SRC_DIR
find . | grep -E '\.(urp|script|installation|variables|vars|pvars|txt)$' | cpio -vdump --quiet $DATAPATH &> $list

# Log copied files
$LOGGER -p user.info $TAG -f $list
$LOGGER -p user.info $TAG "$0: ...copy done."

# Make sure data is written to the USB key
sync
sync

# Notify user it is ok to remove USB key
echo "<- USB" | DISPLAY=:0 aosd_cat -x 200 -y -210 -n "Arial Black 80"
