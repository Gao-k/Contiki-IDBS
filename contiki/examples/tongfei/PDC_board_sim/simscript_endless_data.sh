#!/bin/csh
set PROTOCOL_list=(adc pdc)
set SF_list=(10 18)
set FAORNOT_list=(fa nfa)
set PGI_list=(1 3 5 7 9)
set UNIT=s
set CONTIKIDIR="/mnt/hgfs/ContikiPro/1LatestContiki/contiki"
set SCRIPTDIR="/mnt/hgfs/ContikiPro/1LatestContiki/contiki/examples/tongfei/PDC_board_sim"
set CSCFILENAME="ADC-PDC-5.csc"
set CSCFILE = "$SCRIPTDIR/$CSCFILENAME"
set makefile = "$SCRIPTDIR/Makefile"
set COOJASIM = "1" # 1: YES, 0: NO
set SUPPORTRANDOMDRIFT="1" # 1: YES, 0: NO

# need to modify according to it's sending fixed or endless data
#set LOGSDIR="$SCRIPTDIR/logs_fixed_data"
set LOGSDIR="$SCRIPTDIR/logs_endless_data"
set DATANUM="-1"	#send endless data
#set DATANUM="100"	#send fixed number of data
# simulation time:
	# 3900000: 65 m (for sending endless data)
	# 2100000: 35 m (for sending a fixed number of data)
#set SIMTIME = "2100000"
set SIMTIME = "3900000"

# key words in $makefile
set mf_key_0 = "TOTAL_DATA_NUM"			#target 0, to determine sending fixed number of data or endless data
set mf_key_1 = "ADCSC_SUPPORT"			#target 1
set mf_key_2 = "SF"						#target 2
set mf_key_3 = "ADDRESS_FREE_SUPPORT"	#target 3
set mf_key_4 = "DATA_INTERVAL"			#target 4
set mf_key_5 = "RANDOM_DRIFT_IN_COOJA_SUPPORT"			#target 5
set mf_key_6 = "IS_COOJA_SIM"			#target 6

# key words in $CSCFILE
set csc_key_0 = "TIMEOUT"
set TIMEOUT = "$csc_key_0($SIMTIME);"
echo " "
echo "For sending endless data ..."
echo " "
foreach PROTOCOL($PROTOCOL_list)
	#modify makefile: adc or 
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
				echo $CURRENTFOLDER
				
				cd $SCRIPTDIR
				make -s TARGET=z1 clean
				
				cd $LOGSDIR/$CURRENTFOLDER
				rm -f *.*
				
				#modify the cooja csc file
				set csc_key_0_ln = `nl -ba $CSCFILE|grep "$csc_key_0"|awk '{print $1}'` # ln: line number
				sed -i "${csc_key_0_ln}c $TIMEOUT" $CSCFILE
				sleep 0.5s
				cp $CSCFILE ./
				
				gnome-terminal -x  bash -c "java -mx512m -jar $CONTIKIDIR/tools/cooja/dist/cooja.jar -nogui="$CSCFILE" -contiki="$CONTIKIDIR"; exec bash"
				
				sleep 1.5m
				cd $SCRIPTDIR
			end
		end
	end
end

#echo "Done (fixed data)! Congratulations!"
echo "Done (endless data)! Congratulations!"