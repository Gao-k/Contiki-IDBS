#!/bin/csh
set PROTOCOL_list=(pdc adc)
set SF_list=(18 10)
set FAORNOT_list=(fa nfa)
set PGI_list=(10 20 30 40 50)
set Random_seed = 123377
set Sim_times = 3
set UNIT=s

#set CONTIKILOCALDIR="/home/feitong/Dropbox/ContikiPro/1LatestContiki/contiki"
set CONTIKILOCALDIR="/mnt/hgfs/ContikiPro/1LatestContiki/contiki"
set SCRIPTDIR="$CONTIKILOCALDIR/examples/tongfei/PDC"
set CSCFILENAME="ADC-PDC-30-z1-sky-exp.csc"
set CSCFILE = "$SCRIPTDIR/$CSCFILENAME"
set makefile = "$SCRIPTDIR/Makefile"
set COOJASIM = "1" # 1: YES, 0: NO
set SUPPORTRANDOMDRIFT="1" # 1: YES, 0: NO

# need to modify according to it's sending fixed or endless data
#set LOGSDIR="$SCRIPTDIR/logs_fixed_data_2"
#set LOGSDIR="$SCRIPTDIR/logs_endless_data"
set DATANUM="-1"	#send endless data
#set DATANUM="20"	#send fixed number of data
# simulation time:
	# 3900000: 65 m (for sending endless data)
	# 4200000: 70 m (for sending fixed data)
	# 2100000: 35 m (for sending a fixed number of data)
set SIMTIME = "2100000"
#set SIMTIME = "3900000"

# key words in $makefile
set total_data_num_key = "TOTAL_DATA_NUM"			#target 0, to determine sending fixed number of data or endless data
set adc_support_key = "ADCSC_SUPPORT"			#target 1
set sf_key = "SF"						#target 2
set fa_support_key = "ADDRESS_FREE_SUPPORT"	#target 3
set data_interval_key = "DATA_INTERVAL"			#target 4
set random_drift_support_key = "RANDOM_DRIFT_IN_COOJA_SUPPORT"			#target 5
set is_cooja_sim_key = "IS_COOJA_SIM"			#target 6

# key words in $CSCFILE
set csc_timeout_key = "TIMEOUT"
set TIMEOUT = "$csc_timeout_key($SIMTIME);"
set csc_randseed_key = "<randomseed>"

while ($Sim_times > 0)
	echo " "
	echo "A new round simulation:"
	echo " "
	@ Sim_times = $Sim_times - 1
	
	set csc_randseed_key_ln = `nl -ba $CSCFILE|grep "$csc_randseed_key"|awk '{print $1}'` 
	sed -i "${csc_randseed_key_ln}c <randomseed>$Random_seed</randomseed>" $CSCFILE
	sleep 0.5s
	set LOGSDIR="$SCRIPTDIR/logs_endless_data_new_$Random_seed"
	@ Random_seed = $Random_seed + 5
	mkdir $LOGSDIR
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
					echo $CURRENTFOLDER
					mkdir $LOGSDIR/$CURRENTFOLDER
					
					cd $SCRIPTDIR
					make -s TARGET=z1 clean
					make -s TARGET=sky clean
					make -s TARGET=exp5438 clean
					
					
					cd $LOGSDIR/$CURRENTFOLDER
					rm -f *.*
					 
					#modify the cooja csc file
					# ln: line number
					set csc_timeout_key_ln = `nl -ba $CSCFILE|grep "$csc_timeout_key"|awk '{print $1}'` 
					sed -i "${csc_timeout_key_ln}c $TIMEOUT" $CSCFILE
					sleep 0.5s
					cp $CSCFILE ./
					
					gnome-terminal -x  bash -c "java -mx512m -jar $CONTIKILOCALDIR/tools/cooja/dist/cooja.jar -nogui="$CSCFILE" -contiki="$CONTIKILOCALDIR"; exec bash"
					
					sleep 5m
					cd $SCRIPTDIR
				end
			end
		end
	end
end

echo "Done (fixed data)! Congratulations!"
#echo "Done (endless data)! Congratulations!"
