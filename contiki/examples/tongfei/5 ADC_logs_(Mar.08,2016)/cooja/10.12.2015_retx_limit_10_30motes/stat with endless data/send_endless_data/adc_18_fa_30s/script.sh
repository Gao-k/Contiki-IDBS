CONTIKIDIR="/mnt/hgfs/ContikiPro/1LatestContiki/contiki"
echo -e "\nRemove testlog file: "
rm *.testlog
echo -e "\nCopy the csc file.\n"
cp $CONTIKIDIR/examples/tongfei/PDC/ADC-PDC-30.csc ./
java -mx512m -jar $CONTIKIDIR/tools/cooja/dist/cooja.jar -nogui="./ADC-PDC-30.csc" -contiki="$CONTIKIDIR"
