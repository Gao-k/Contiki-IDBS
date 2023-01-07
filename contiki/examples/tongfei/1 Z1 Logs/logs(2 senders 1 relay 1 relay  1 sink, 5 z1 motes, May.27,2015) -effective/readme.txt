5 z1 motes form a topology as follows:
2 senders 1 relay 1 relay 1 sink

sink <-- node2 <-- node5 <-- node6(3) 
                   node5 <-- node7(4)

sink1: Z1RC4243   (/dev/ttyUSB7)
node2: Z1RC4239  (/dev/ttyUSB8)
node5: Z1RC4841 (/dev/ttyUSB9)
node6: Z1RC4255 (/dev/ttyUSB10)（注意：节点地址由3改为6）
node7: Z1RC4975 (/dev/ttyUSB11)（注意：节点地址由4改为7）

===烧地址===
make clean && make burn-nodeid.upload nodeid=1 nodemac=1 MOTES=/dev/ttyUSB7 && make z1-reset MOTES=/dev/ttyUSB7 && make login MOTES=/dev/ttyUSB7

make clean && make burn-nodeid.upload nodeid=2 nodemac=2 MOTES=/dev/ttyUSB8 && make z1-reset MOTES=/dev/ttyUSB8 && make login MOTES=/dev/ttyUSB8

make clean && make burn-nodeid.upload nodeid=5 nodemac=5 MOTES=/dev/ttyUSB9 && make z1-reset MOTES=/dev/ttyUSB9 && make login MOTES=/dev/ttyUSB9

make clean && make burn-nodeid.upload nodeid=6 nodemac=6 MOTES=/dev/ttyUSB10 && make z1-reset MOTES=/dev/ttyUSB10 && make login MOTES=/dev/ttyUSB10

make clean && make burn-nodeid.upload nodeid=7 nodemac=7 MOTES=/dev/ttyUSB11 && make z1-reset MOTES=/dev/ttyUSB11 && make login MOTES=/dev/ttyUSB11

===下载程序， 一个一个的下===
make hello-world.upload MOTES=/dev/ttyUSB7 && make z1-reset MOTES=/dev/ttyUSB7 && make login MOTES=/dev/ttyUSB7

===运行程序===
make z1-reset MOTES=/dev/ttyUSB7 && make login MOTES=/dev/ttyUSB7 2>&1 | tee logs/sink.txt

make z1-reset MOTES=/dev/ttyUSB8 && make login MOTES=/dev/ttyUSB8 2>&1 | tee logs/2.txt

make z1-reset MOTES=/dev/ttyUSB9 && make login MOTES=/dev/ttyUSB9 2>&1 | tee logs/5.txt

make z1-reset MOTES=/dev/ttyUSB10 && make login MOTES=/dev/ttyUSB10 2>&1 | tee logs/6.txt

make z1-reset MOTES=/dev/ttyUSB11 && make login MOTES=/dev/ttyUSB11 2>&1 | tee logs/7.txt