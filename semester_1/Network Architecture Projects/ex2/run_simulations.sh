#!/bin/bash

ns_script="run_tcl.tcl"

bandwidth="10Mb"
delay="40ms"
cwnds=(1 5 10 15 20 25 30)
echo "Starting Scenario 1: Vary Congestion Window"

for cwnd in "${cwnds[@]}"; do
    tracefile="trace_cwnd${cwnd}.tr"
    echo "Running simulation with cwnd=${cwnd}"
    ns $ns_script $cwnd $bandwidth $delay $tracefile > output_cwnd${cwnd}.log
    awk '{if ($2=="r" && $6=="tcp") rec+=1500;} END {print rec*8/0.7/1000000}' $tracefile > throughput_cwnd${cwnd}.txt
done

echo "Starting Scenario 2: Vary Propagation Delay"
cwnd=30
delays=("2.5ms" "5ms" "10ms" "15ms" "30ms" "40ms")
for d in "${delays[@]}"; do
    tracefile="trace_delay${d}.tr"
    echo "Running simulation with delay=${d}"
    ns $ns_script $cwnd $bandwidth $d $tracefile > output_delay${d}.log
    awk '{if ($2=="r" && $6=="tcp") rec+=1500;} END {print rec*8/0.7/1000000}' $tracefile > throughput_delay${d}.txt
done

echo "Starting Scenario 3: Vary Bandwidth"
delay="40ms"
bandwidths=("1Mb" "5Mb" "10Mb" "15Mb" "20Mb" "25Mb" "30Mb")
for bw in "${bandwidths[@]}"; do
    tracefile="trace_bw${bw}.tr"
    echo "Running simulation with bandwidth=${bw}"
    ns $ns_script $cwnd $bw $delay $tracefile > output_bw${bw}.log
    awk '{if ($2=="r" && $6=="tcp") rec+=1500;} END {print rec*8/0.7/1000000}' $tracefile > throughput_bw${bw}.txt
done

