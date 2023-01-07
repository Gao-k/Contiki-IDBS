#!/bin/csh
set OUTPUT="output_fixed_data.txt"
rm -f $OUTPUT
echo "Starting (fixed data) ..." >> $OUTPUT

set PROTOCOL_list=(adc)
set SF_list=(10 18)
set FAORNOT_list=(fa nfa)
set PGI_list=(1 3 5 7 9)
set UNIT=s
set makefile = "./Makefile"
set COOJASIM = "0" # 1: YES, 0: NO
set SUPPORTRANDOMDRIFT="0" # 1: YES, 0: NO

# need to modify according to it's sending fixed or endless data
set LOGSDIR="./logs_z1"
#set LOGSDIR="./logs_endless_data"
#set DATANUM="-1"	#send endless data
set DATANUM="100"	#send fixed number of data

# key words in $makefile
set total_data_num_key = "TOTAL_DATA_NUM"
set adc_support_key = "ADCSC_SUPPORT"	
set sf_key = "SF"						
set fa_support_key = "ADDRESS_FREE_SUPPORT"			
set data_interval_key = "DATA_INTERVAL"				
set random_drift_support_key = "RANDOM_DRIFT_IN_COOJA_SUPPORT"	
set is_cooja_sim_key = "IS_COOJA_SIM"				

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
			# no combination of pdc and fa
			if($PROTOCOL == pdc && $FAORNOT == fa) then
				sleep 0.5s
				continue
			endif
				
			#modify makefile: support free address or not
			set fa_support_key_ln = `nl -ba $makefile|grep "$fa_support_key "|awk '{print $1}'`
			if($FAORNOT == fa) then
				sed -i "${fa_support_key_ln}c $fa_support_key ?= 1" $makefile
			else if($FAORNOT == nfa) then
				sed -i "${fa_support_key_ln}c $fa_support_key ?= 0" $makefile
			endif
			sleep 0.5s
			foreach PGI($PGI_list)
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
				
				#rm -f $LOGSDIR/$CURRENTFOLDER/*.*

				make -s TARGET=z1 clean
				make -s TARGET=z1 hello-world.upload

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB0 && make login MOTES=/dev/ttyUSB0 2>&1|tee $LOGSDIR/$CURRENTFOLDER/sink.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB1 && make login MOTES=/dev/ttyUSB1 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z2.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB2 && make login MOTES=/dev/ttyUSB2 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z3.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB3 && make login MOTES=/dev/ttyUSB3 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z4.txt; exec bash"

				gnome-terminal -x  bash -c "make z1-reset MOTES=/dev/ttyUSB4 && make login MOTES=/dev/ttyUSB4 2>&1|tee $LOGSDIR/$CURRENTFOLDER/z5.txt; exec bash"

				sleep 35m
				#kill the above five terminals and start next
				pkill -f 'bash -c'
				
			end
		end
	end
end

echo 'Done (fixed data)! Congratulations!' >> $OUTPUT
#echo "Done (endless data)! Congratulations!"
