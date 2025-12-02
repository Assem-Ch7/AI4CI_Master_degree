# example.tcl - Accepts max congestion window, bandwidth, and propagation delay as parameters

set ns [new Simulator]

# Parse input parameters
set maxcwnd [lindex $argv 0]
set bandwidth [lindex $argv 1]
set delay [lindex $argv 2]
set tracefile [lindex $argv 3]

# Open trace files with dynamic name for uniqueness
set ftrace [open $tracefile w]
$ns trace-all $ftrace
set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns ftrace nf
    $ns flush-trace
    close $ftrace
    close $nf
    exit 0
}

proc tracewindow {} {
    global tcp0 ftrace ns
    set time 0.001
    set now [$ns now]
    set now [format "%.3f" $now]
    if {![info exists tcp0]} { return }
    set cwnd [$tcp0 set cwnd_]
    puts $ftrace "$now $cwnd"
    $ns at [expr $now + $time] {tracewindow}
}

Agent/TCP set packetSize_ 1500
Agent/TCP set maxcwnd_ $maxcwnd

set n0 [$ns node]
set n1 [$ns node]

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set ftp [new Application/FTP]
$ftp attach-agent $tcp0

set tcp1 [new Agent/TCPSink]
$ns attach-agent $n1 $tcp1

$ns duplex-link $n0 $n1 $bandwidth $delay DropTail
$ns connect $tcp0 $tcp1

$ns at 0.0 {$ftp start}
$ns at 0.7 {$ftp stop}
$ns at 0.0 {tracewindow}
$ns at 1.0 {finish}

$ns run

