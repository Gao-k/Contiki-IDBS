make hello-world.upload TARGET=micaz PORT=/dev/ttyUSB0

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z5.txt; exec bash"

cat < /dev/ttyUSB0 2>&1 | tee $LOGSDIR/$CURRENTFOLDER/m1.txt


