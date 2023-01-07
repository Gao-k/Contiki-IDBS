CONTIKIDIR="/mnt/hgfs/ContikiPro/1LatestContiki/contiki"
CSCFILENAME="ADC-PDC-6.csc"
echo -e "\n\nCurrent file: $CSCFILENAME\n"
echo -e "\nRemove testlog file: "
rm *.testlog
echo -e "\nCopy the csc file.\n"
cp $CONTIKIDIR/examples/tongfei/PDC_board/$CSCFILENAME ./
java -mx512m -jar $CONTIKIDIR/tools/cooja/dist/cooja.jar -nogui="./$CSCFILENAME" -contiki="$CONTIKIDIR"
