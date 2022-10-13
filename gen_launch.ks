//general launch script currently eastward 0 degree inclination at about 70km.
//I plan to make paremeters adjustable in future.
//Version 1.0
//Author: Joshua Higginbotham

lock steering to heading (90, 90).
clearscreen.

print "Launching in".
from {local countdown is 10.} until countdown = 0 step {set countdown to countdown - 1.} do {
    print "..." + countdown + "       " at (0, 2).
    wait 1.
}
lock twr2 to min(1, (2*ship:mass*(ship:body:mu/(ship:altitude+ship:body:radius)^2)/max(0.001,ship:availablethrust))).
lock thrott to twr2.
lock throttle to thrott.
print "Liftoff...".
stage.
wait until altitude > 500.
when maxThrust = 0 then {
    print "Staging".
    lock throttle to 0.
    wait 1.
    stage.
    wait 1.
    lock throttle to thrott.
    preserve.
}
set goalheight to 70000.
set goalvel to sqrt(ship:body:mu/(ship:body:radius+goalheight)).
set veladj to goalvel * 0.62.
lock steering to heading (90, 90-(90*min(1,Ship:velocity:orbit:mag/veladj))).
wait until ship:apoapsis > 70000.
lock thrott to 0.
wait until ship:altitude > 50000.
lock steering to heading (90, 0).
set curap to ship:apoapsis.
wait 0.5.
set wrptime to time:seconds + ship:obt:eta:apoapsis -60.
kuniverse:timewarp:warpto(wrptime).
wait until ship:altitude > curap - 700.
lock thrott to 1.
wait until ship:periapsis > 50000.
lock thrott to 0.
print "You are now in orbit!".
print "Circularizing...".
set curap to ship:apoapsis.
wait 0.5.
set wrptime to time:seconds + ship:obt:eta:apoapsis -60.
kuniverse:timewarp:warpto(wrptime).
lock steering to prograde.
wait until eta:apoapsis < 30.
lock thrott to 1.
wait until ship:periapsis > curap - 2000.
lock thrott to 0.
set curap to ship:apoapsis.
wait 0.5.
set wrptime to time:seconds + ship:obt:eta:apoapsis -60.
kuniverse:timewarp:warpto(wrptime).
wait until eta:apoapsis < 15.
lock thrott to 0.1.
wait until ship:periapsis > curap - 20.
lock thrott to 0.
print "Orbit circualrized.".
print "Eccentricity: " + ship:orbit:eccentricity.

set ship:control:pilotmainthrottle to 0.
unlock steering.
unlock throttle.