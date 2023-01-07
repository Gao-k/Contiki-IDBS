#!/bin/csh
set OUTPUT="output_endless_data.txt"
rm -f $OUTPUT
echo "Starting (endless data) ..." >> $OUTPUT

set PROTOCOL_list=(adc pdc)
set SF_list=(18 10)
set FAORNOT_list=(fa nfa)
set PGI_list=(1 3 5 7 9)
set UNIT=s
set makefile = "./Makefile"
set COOJASIM = "0" # 1: YES, 0: NO
set SUPPORTRANDOMDRIFT="0" # 1: YES, 0: NO

# need to modify according to it's sending fixed or endless data
#set LOGSDIR="./logs_fixed_data"
set LOGSDIR="./logs_endless_data"
set DATANUM="-1"	#send endless data
#set DATANUM="100"	#send fixed number of data

# key words in $makefile
set mf_key_0 = "TOTAL_DATA_NUM"					#makefile key 0, to determine sending fixed number of data or endless data
set mf_key_1 = "ADCSC_SUPPORT"					#target 1
set mf_key_2 = "SF"								#target 2
set mf_key_3 = "ADDRESS_FREE_SUPPORT"			#target 3
set mf_key_4 = "DATA_INTERVAL"					#target 4
set mf_key_5 = "RANDOM_DRIFT_IN_COOJA_SUPPORT"	#target 5
set mf_key_6 = "IS_COOJA_SIM"					#target 6

foreach PROTOCOL($PROTOCOL_list)
	#modify makefile: adc or pdc
	sleep 0.5s
	set mf_key_1_ln = `nl -ba $makefile|grep "$mf_key_1 "|awk '{print $1}'` # ln: line number
	if($PROTOCOL == adc) then
		sed -i "${mf_key_1_ln}c $mf_key_1 ?= 1" $makefile
	else if($PROTOCOL == pdc) then
		sed -i "${mf_key_1_ln}c $mf_key_1 ?= 0" $makefile
	endif
	sleep 0.5s	#to avoid the permission-denited issue when continuously modifying the makefile
	
	foreach SF($SF_list)
			#modify makefile: sleeping factor: 10 or 18
			set mf_key_2_ln = `nl -ba $makefile|grep "$mf_key_2 "|awk '{print $1}'`
			sed -i "${mf_key_2_ln}c $mf_key_2 ?= $SF" $makefile
			sleep 0.5s
		foreach FAORNOT($FAORNOT_list)
			#modify makefile: support free address or not
			set mf_key_3_ln = `nl -ba $makefile|grep "$mf_key_3 "|awk '{print $1}'`
			if($FAORNOT == fa) then
				sed -i "${mf_key_3_ln}c $mf_key_3 ?= 1" $makefile
			else if($FAORNOT == nfa) then
				sed -i "${mf_key_3_ln}c $mf_key_3 ?= 0" $makefile
			endif
			sleep 0.5s
			foreach PGI($PGI_list)
				if($PROTOCOL == pdc && $FAORNOT == fa) then
					sleep 0.5s
					continue
				endif

				#modify makefile: set packet generation interval
				set mf_key_4_ln = `nl -ba $makefile|grep "$mf_key_4 "|awk '{print $1}'`
				sed -i "${mf_key_4_ln}c $mf_key_4 ?= $PGI" $makefile
				sleep 0.5s
				
				#modify makefile: how many data to be sent: fixed number of endless
				set mf_key_0_ln = `nl -ba $makefile|grep "$mf_key_0 "|awk '{print $1}'` # ln: line number
				sed -i "${mf_key_0_ln}c $mf_key_0 ?= $DATANUM" $makefile
				sleep 0.5s
				
				#modify makefile: support random drift?
				set mf_key_5_ln = `nl -ba $makefile|grep "$mf_key_5 "|awk '{print $1}'` # ln: line number
				sed -i "${mf_key_5_ln}c $mf_key_5 ?= $SUPPORTRANDOMDRIFT" $makefile
				sleep 0.5s
				
				#modify makefile: is it cooja simulation?
				set mf_key_6_ln = `nl -ba $makefile|grep "$mf_key_6 "|awk '{print $1}'` # ln: line number
				sed -i "${mf_key_6_ln}c $mf_key_6 ?= $COOJASIM" $makefile
				sleep 0.5s
				
				set CURRENTFOLDER=${PROTOCOL}_${SF}_${FAORNOT}_${PGI}${UNIT}
				echo " "
				echo $LOGSDIR/$CURRENTFOLDER >> $OUTPUT
				
				#rm -f $LOGSDIR/$CURRENTFOLDER/*.*

				make -s TARGET=z1 clean
				make -s TARGET=z1 hello-world.upload

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB0 && make login MOTES=/dev/ttyUSB0 2>&1|tee $LOGSDIR/$CURRENTFOLDER/sink.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB1 && make login MOTES=/dev/ttyUSB1 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z2.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB2 && make login MOTES=/dev/ttyUSB2 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z3.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z4.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z5.txt; exec bash"

				sleep 65m
				pkill -f 'bash -c'
				
			end
		end
	end
end

#echo "Done (fixed data)! Congratulations!"
echo "Done (endless data)! Congratulations!" >> $OUTPUT
