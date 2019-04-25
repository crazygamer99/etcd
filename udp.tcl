#create a network simulator object
set ns [new Simulator]

#open the nam trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#define a finish procedure
proc finish {} {
global ns nf
$ns flush-trace
#close the trace file
close $nf
#execute the nam trace file
exec nam out.nam &
exit0
}

#create two nodes
set n0 [$ns node]
set n1 [$ns node]

#create a duplex node between nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

#create a udp agent and attach it to node0
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0

#create acbr traffic source and attach it to udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

#create a null agent and attach it to node1
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0

#connect the traffic
$ns connect $null0 $udp0

#schedule event for cr start
$ns at 0.7 "$cbr0 start"
$ns at 4.3 "$cbr0 stop"


#call the finish procedure
$ns at 5.0 "finish"

#run the simulation
$ns run
