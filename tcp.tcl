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

#give node position
$ns duplex-link-op $n0 $n1 orient right-down

#set up a tcp connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#setup acbr over tcp
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp
$cbr set type_ CBR
$cbr set packet_Size_ 500
$cbr set rate_ 1mb
$cbr set random_ false

#schedule event for cbr start
$ns at 0.1 "$cbr start"
$ns at 4.5 "$cbr stop"


#call the finish procedure
$ns at 5.0 "finish"

#run the simulation
$ns run
