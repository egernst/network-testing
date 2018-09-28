#!/bin/bash -x


#
# run tests between L2 and client.  Very much
# assumes you are running on the L1
#
client_dp_ip=192.168.0.10
client_cp_ip=10.0.0.5
l2_dp_ip=192.168.0.20
l2_cp_ip=0
testlength=180
resultdir=$1
tests=(receive )
#transmit)
ntttcpThreads=(1)
#2 3 4 5 6 7 8 9 10 15 20 30)
rxargs="ntttcp -r -m $c,*,$rxip -t $testlength"
txargs="ntttcp -s -m $c,*,$txip -t $testlength"
mkdir $resultdir

for testtype in "${tests[@]}"; do
  for c in "${ntttcpThreads[@]}"; do

    if [ $testtype ==  "receive" ]
    then
	rxip=$l2_dp_ip
	txtip=$client_dp_ip
	sudo sleep 18 &

	sudo ssh kata@$client_cp_ip sleep 180 & 

	txpid=$!
	sleep 5
	wait $txpid
    fi
  done
done
