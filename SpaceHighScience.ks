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
lock twr2 to min(1, (2*ship:mass*(ship:body:mu/(ship:altitude+ship:body:radius)^2)/max(0.001,ship:availablethrust))).
lock throttle to twr2.
print "Liftoff...".
stage.
wait until altitude > 500.
when maxThrust = 0 then {
    print "Staging".
    lock throttle to 0.
    wait 1.
    stage.
    wait 1.
    lock throttle to twr2.
}
set goalheight to 70000.
set goalvel to sqrt(ship:body:mu/(ship:body:radius+goalheight)).
set veladj to goalvel * 0.62.
lock steering to heading (90, 90-(90*min(1,Ship:velocity:orbit:mag/veladj))).
wait until ship:apoapsis > 6000000.
lock throttle to 0.
wait until ship:altitude > 50000.
lock steering to heading (90, 0).
set curap to ship:apoapsis.
wait 0.5.
set wrptime to time:seconds + ship:obt:eta:apoapsis -60.
kuniverse:timewarp:warpto(wrptime).
wait until ship:altitude > curap - 700.
lock throttle to 1.
wait until ship:periapsis > 50000.
lock throttle to 0.
print "You are now in orbit!".
print "doing science...".
toggle lights.
lock steering to ship:retrograde.
wait 30.
print "deorbiting".
lock throttle to 0.01.
wait until ship:periapsis < 15000.
lock throttle to 0.
print "decending".
wait until ship:altitude < 50000.
print "Burning extra fuel.".
lock throttle to 1.
wait until ship:maxThrust < 0.1.
wait 1. 
stage.
wait 1.
lock steering to ship:srfretrograde.
print "lowering to chute range.".
wait until ship:altitude <4000.
print "deploying chutes".
stage.
gear on.
wait 10.
lock steering to up.
wait until ship:status = "landed" or "splashed".
Print "done".
set ship:control:pilotmainthrottle to 0.
unlock throttle.