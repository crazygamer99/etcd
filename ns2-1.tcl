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

#call the finish procedure
$ns at 5.0 "finish"

#run the simulation
$ns run
