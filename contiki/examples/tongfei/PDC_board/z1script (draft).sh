PROTOCOL=adc
SF=18
FAORNOT=nfa
PGI=1
UNIT=s
CURRENTFOLDER=${PROTOCOL}_${SF}_${FAORNOT}_${PGI}${UNIT}

make clean
make -n hello-world.upload

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB0 && make login MOTES=/dev/ttyUSB0 2>&1|tee logs/$CURRENTFOLDER/sink.txt; exec bash"

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB1 && make login MOTES=/dev/ttyUSB1 2>&1|tee logs/$CURRENTFOLDER/z2.txt; exec bash"

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB2 && make login MOTES=/dev/ttyUSB2 2>&1|tee logs/$CURRENTFOLDER/z3.txt; exec bash"

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee logs/$CURRENTFOLDER/z4.txt; exec bash"

gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee logs/$CURRENTFOLDER/z5.txt; exec bash"

#get process ID
#ps -ef | grep 'bash -c'|grep -v grep | awk '{print $2}'
#kill 
#pkill -f 'bash -c'
#sed -i 's/DATA_INTERVAL ?= 9/DATA_INTERVAL ?= 1/g' Makefile
