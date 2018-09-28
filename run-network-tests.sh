#!/bin/bash


#
# run tests between L2 and client.  Very much
# assumes you are running on the L1
#
clientip=192.168.0.10
l2ip=192.168.0.20
testlength=180
tests=(receive transmit)
ntttcpThreads=(1 2 3 4 5 6 7 8 9 10 15 20 30)
rxargs="ntttcp -r -m $c,*,$rxip -t $testlength"
txargs="ntttcp -s -m $c,*,$txip -t $testlength"
mkdir $resultdir

for testtype in "${tests[@]}"; do
  for c in "${ntttcpThreads[@]}"; do
    if [ $testtype -eq "receive" ] then
      rxip=$l2ip
      txtip=$clientip
      sudo ntttcp $rxargs &> $resultsdir/$testtype-$c-results.txt &
      rxpid=$!
      sudo ssh kata@$l2ip ntttcp $txargs &> /dev/null &
      txpid=$!
      sleep 5
      sudo ssh kata@$l2ip measure.sh 5 20 &
      ./measure.sh 5 20 > $resultsdir/$testtype-$c-l1-measure.log
      remoteMeasurePID=$!
      waitfor $remoteMeasurePID
      waitfor $txpid
      waitfor $rxpid
    fi
  done
done
