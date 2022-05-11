//launch script for polar orbit around rhode.
function lko_deorb {
local deorb to node (time:seconds+ship:orbit:period * 3 +200, 0, 0, -50).
add deorb.
until deorb:orbit:periapsis < 10000 {
    set deorb:prograde to deorb:prograde - 0.1.
}
if addons:tr:hasimpact = false { print "Trajectories error". wait until false.}
set addons:tr:retrograde to true.
until (addons:tr:impactpos:lng + 55) < 5 AND (addons:tr:impactpos:lng + 55) > 0 {
    set deorb:time to deorb:time - 1.
}}
lock steering to heading (90, 90).
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
wait until ship:altitude > curap - 7.
lock throttle to 0.1.
wait until ship:periapsis > curap - 15.
lock throttle to 0.
lock steering to ship:retrograde.
lko_deorb().
set nd to nextNode.
kuniverse:timewarp:warpto(nd:time  - 60).
print "Deorbiting.".
wait until time > nd:time -1.
lock throttle to 1.
wait until ship:periapsis < 10000.
lock throttle to 0.
wait until ship:altitude < 50000.
lock steering to ship:srfretrograde.
stage.
wait until ship:altitude < 2500.
print "Script complete exiting.".
set ship:control:pilotmainthrottle to 0.
unlock steering.
unlock throttle.