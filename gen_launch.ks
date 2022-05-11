//general launch script currently eastward 0 degree inclination at about 70km.
//I plan to make paremeters adjustable in future.
//Version 1.0

lock steering to heading (90, 90).
clearscreen.

print "Launching in".
from {local countdown is 10.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown + "       " at (0, 2).
    wait 1.
}
lock throttle to min(1, (2*ship:mass*(ship:body:mu/(ship:altitude+ship:body:radius)^2)/max(0.001,ship:availablethrust))).
print "Liftoff...".
stage.
wait until altitude > 500.
when maxThrust = 0 then {
    print "Staging".
    set prevthrust to throttle.
    lock throttle to 0.
    wait 1.
    stage.
    wait 1.
    lock throttle to prevthrust.
}
lock steering to heading (90, 90-(90*(ship:altitude/25000))).
wait until ship:altitude > 25000.
lock steering to heading (90, 0).
wait until ship:apoapsis > 70000.
lock throttle to 0.
wait until ship:altitude > 50000.
lock steering to heading (90, 0).
set curap to ship:apoapsis.
wait until ship:altitude > curap - 700.
lock throttle to 1.
wait until ship:periapsis > 50000.
lock throttle to 0.
print "You are now in orbit!".
print "Circularizing...".
set curap to ship:apoapsis.
lock steering to prograde.
wait until ship:apoapsis:eta < 15.
lock throttle to 0.1.
wait until ship:periapsis > curap - 20.
lock throttle to 0.

set ship:control:pilotmainthrottle to 0.
unlock steering.
unlock throttle.