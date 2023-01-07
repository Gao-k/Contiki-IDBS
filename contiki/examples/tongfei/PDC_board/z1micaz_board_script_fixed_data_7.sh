#!/bin/csh
set OUTPUT="output_fixed_data.txt"
rm -f $OUTPUT
echo "Starting (fixed data) ..." >> $OUTPUT

set PROTOCOL_list=(pdc adc)
set SF_list=(18 10)
set FAORNOT_list=(nfa)
set PGI_list=(1 3 5 7 9)
set UNIT=s
set makefile = "./Makefile"
set COOJASIM = "0" # 1: YES, 0: NO
set SUPPORTRANDOMDRIFT="0" # 1: YES, 0: NO

# need to modify according to it's sending fixed or endless data
set LOGSDIR="./logs_5_z1_2_micaz_new_4_datanum_0"
#set LOGSDIR="./logs_endless_data"
#set DATANUM="-1"	#send endless data
#set DATANUM="50"	#send fixed number of data
set DATANUM="0"	#send fixed number of data

# key words in $makefile
set total_data_num_key = "TOTAL_DATA_NUM"					#makefile key 0, to determine sending fixed number of data or endless data
set adc_support_key = "ADCSC_SUPPORT"					#target 1
set sf_key = "SF"								#target 2
set fa_support_key = "ADDRESS_FREE_SUPPORT"			#target 3
set data_interval_key = "DATA_INTERVAL"					#target 4
set random_drift_support_key = "RANDOM_DRIFT_IN_COOJA_SUPPORT"	#target 5
set is_cooja_sim_key = "IS_COOJA_SIM"					#target 6

foreach PROTOCOL($PROTOCOL_list)
	#modify makefile: adc or pdc
	sleep 0.5s
	set adc_support_key_ln = `nl -ba $makefile|grep "$adc_support_key "|awk '{print $1}'` # ln: line number
	if($PROTOCOL == adc) then
		sed -i "${adc_support_key_ln}c $adc_support_key ?= 1" $makefile
	else if($PROTOCOL == pdc) then
		sed -i "${adc_support_key_ln}c $adc_support_key ?= 0" $makefile
	endif
	sleep 0.5s	#to avoid the permission-denited issue when continuously modifying the makefile
	
	foreach SF($SF_list)
			#modify makefile: sleeping factor: 10 or 18
			set sf_key_ln = `nl -ba $makefile|grep "$sf_key "|awk '{print $1}'`
			sed -i "${sf_key_ln}c $sf_key ?= $SF" $makefile
			sleep 0.5s
		foreach FAORNOT($FAORNOT_list)
			#modify makefile: support free address or not
			set fa_support_key_ln = `nl -ba $makefile|grep "$fa_support_key "|awk '{print $1}'`
			if($FAORNOT == fa) then
				sed -i "${fa_support_key_ln}c $fa_support_key ?= 1" $makefile
			else if($FAORNOT == nfa) then
				sed -i "${fa_support_key_ln}c $fa_support_key ?= 0" $makefile
			endif
			sleep 0.5s
			foreach PGI($PGI_list)

				if($PROTOCOL == pdc && $FAORNOT == fa) then
					sleep 0.5s
					continue
				endif

				#modify makefile: set packet generation interval
				set data_interval_key_ln = `nl -ba $makefile|grep "$data_interval_key "|awk '{print $1}'`
				sed -i "${data_interval_key_ln}c $data_interval_key ?= $PGI" $makefile
				sleep 0.5s
				
				#modify makefile: how many data to be sent: fixed number of endless
				set total_data_num_key_ln = `nl -ba $makefile|grep "$total_data_num_key "|awk '{print $1}'` # ln: line number
				sed -i "${total_data_num_key_ln}c $total_data_num_key ?= $DATANUM" $makefile
				sleep 0.5s
				
				#modify makefile: support random drift?
				set random_drift_support_key_ln = `nl -ba $makefile|grep "$random_drift_support_key "|awk '{print $1}'` # ln: line number
				sed -i "${random_drift_support_key_ln}c $random_drift_support_key ?= $SUPPORTRANDOMDRIFT" $makefile
				sleep 0.5s
				
				#modify makefile: is it cooja simulation?
				set is_cooja_sim_key_ln = `nl -ba $makefile|grep "$is_cooja_sim_key "|awk '{print $1}'` # ln: line number
				sed -i "${is_cooja_sim_key_ln}c $is_cooja_sim_key ?= $COOJASIM" $makefile
				sleep 0.5s
				
				
				set CURRENTFOLDER=${PROTOCOL}_${SF}_${FAORNOT}_${PGI}${UNIT}
				echo " "
				echo $LOGSDIR/$CURRENTFOLDER >> $OUTPUT
				mkdir $LOGSDIR/$CURRENTFOLDER
				
				rm -f $LOGSDIR/$CURRENTFOLDER/*.*

				make -s TARGET=micaz clean
				make -s TARGET=micaz hello-world.micaz

				make -s TARGET=z1 clean
				make -s TARGET=z1 hello-world.upload
				

				#gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z4.txt; exec bash"

				#gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z5.txt; exec bash"

				#gnome-terminal -x  bash -c "make hello-world.upload TARGET=micaz PORT=/dev/ttyUSB3; cat < /dev/ttyUSB3 2>&1 | tee $LOGSDIR/$CURRENTFOLDER/m1.txt; exec bash"
				gnome-terminal -x  bash -c "make hello-world.upload TARGET=micaz PORT=/dev/ttyUSB5; cat < /dev/ttyUSB5 2>&1 | tee $LOGSDIR/$CURRENTFOLDER/m1.txt; exec bash"
				
				#minicom -8 -b9600 -D/dev/ttyUSB1
				gnome-terminal -x  bash -c "make hello-world.upload TARGET=micaz PORT=/dev/ttyUSB6; cat < /dev/ttyUSB6 2>&1 | tee $LOGSDIR/$CURRENTFOLDER/m2.txt; exec bash"
				sleep 13s

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB0 && make login MOTES=/dev/ttyUSB0 2>&1|tee $LOGSDIR/$CURRENTFOLDER/sink.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB1 && make login MOTES=/dev/ttyUSB1 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z2.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB2 && make login MOTES=/dev/ttyUSB2 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z3.txt; exec bash"
				
				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z4.txt; exec bash"
				
				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z5.txt; exec bash"
				sleep 30m
				pkill -f 'bash -c'
				
			end
		end
	end
end

echo 'Done (fixed data)! Congratulations!' >> $OUTPUT
#echo "Done (endless data)! Congratulations!"
