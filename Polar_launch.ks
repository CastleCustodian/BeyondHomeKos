//launch script for polar orbit around rhode.
lock steering to heading (0, 90).
clearscreen.
print "Launching in".
from {local countdown is 10.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown + "       " at (0, 2).
    wait 1.
}
lock throttle to min(1, (2*ship:mass*7.6/max(0.001,ship:availablethrust))).
print "Liftoff...".
stage.
wait until altitude > 500.
when maxThrust = 0 then {
    print "Staging".
    lock throttle to 0.
    wait 1.
    stage.
    wait 1.
    lock throttle to min(1, (2*ship:mass*7.6/max(0.001,ship:availablethrust))).
}
lock steering to heading (0, 90-(90*(ship:altitude/50000))).
wait until ship:apoapsis > 70000.
lock throttle to 0.
wait until ship:altitude > 50000.
lock steering to heading (0, 0).
set curap to ship:apoapsis.
wait until ship:altitude > curap - 100.
lock throttle to 1.
wait until ship:periapsis > 50000.
lock throttle to 0.
print "You are now in orbit!".
print "Circularizing...".
set curap to ship:apoapsis.
wait until ship:altitude > curap - 15.
lock throttle to 0.1.
wait until ship:periapsis > curap - 15.
lock throttle to 0.
print "Script complete exiting.".
set ship:control:pilotmainthrottle to 0.
unlock steering.
unlock throttle.