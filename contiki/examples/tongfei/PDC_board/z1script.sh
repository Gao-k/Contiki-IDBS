#!/bin/csh
set PROTOCOL_list=(adc pdc)
set SF_list=(18)
set FAORNOT_list=(nfa)
set PGI_list=(3)
set UNIT=s

set makefile = "./Makefile"
set t1 = "ADCSC_SUPPORT"
set t2 = "SF"
set t3 = "ADDRESS_FREE_SUPPORT"
set t4 = "DATA_INTERVAL"
set t1_ln = `nl -ba $makefile|grep "$t1 "|awk '{print $1}'`
set t2_ln = `nl -ba $makefile|grep "$t2 "|awk '{print $1}'`
set t3_ln = `nl -ba $makefile|grep "$t3 "|awk '{print $1}'`
set t4_ln = `nl -ba $makefile|grep "$t4 "|awk '{print $1}'`
echo $t1_ln

foreach PROTOCOL($PROTOCOL_list)
	if($PROTOCOL == adc) then
		sed -i "${t1_ln}c $t1 ?= 1" $makefile
	else if($PROTOCOL == pdc) then
		sed -i "${t1_ln}c $t1 ?= 0" $makefile
	endif

	foreach SF($SF_list)
			sed -i "${t2_ln}c $t2 ?= $SF" $makefile
			
		foreach FAORNOT($FAORNOT_list)
			if($FAORNOT == fa) then
				sed -i "${t3_ln}c $t3 ?= 1" $makefile
			else if($FAORNOT == nfa) then
				sed -i "${t3_ln}c $t3 ?= 0" $makefile
			endif

			foreach PGI($PGI_list)
				sed -i "${t4_ln}c $t4 ?= $PGI" $makefile
				if($PROTOCOL == pdc && $FAORNOT == fa) then
					continue
				endif
				set CURRENTFOLDER=${PROTOCOL}_${SF}_${FAORNOT}_${PGI}${UNIT}
				echo $CURRENTFOLDER
				
				make clean
				make hello-world.upload

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB0 && make login MOTES=/dev/ttyUSB0 2>&1|tee logs/$CURRENTFOLDER/sink.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB1 && make login MOTES=/dev/ttyUSB1 2>&1|tee logs/$CURRENTFOLDER/z2.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB2 && make login MOTES=/dev/ttyUSB2 2>&1|tee logs/$CURRENTFOLDER/z3.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee logs/$CURRENTFOLDER/z4.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee logs/$CURRENTFOLDER/z5.txt; exec bash"

				sleep 45m
				pkill -f 'bash -c'


			end
		end
	end
end

echo "Done! Congratulations!"
#get process ID
#ps -ef | grep 'bash -c'|grep -v grep | awk '{print $2}'
#kill 
#pkill -f 'bash -c'
#sed -i 's/DATA_INTERVAL ?= 9/DATA_INTERVAL ?= 1/g' Makefile
