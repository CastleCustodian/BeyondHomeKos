//launch script for polar orbit around rhode.
wait until ship:unpacked.
if career():candoactions {
core:doaction("Open Terminal", true).
}
copypath("0:/gen_launch.ks","1:/").
function lko_deorb {
local deorb to node (time:seconds+ship:orbit:period * 3 +200, 0, 0, -50).
add deorb.
until deorb:orbit:periapsis < 10000 {
    set deorb:prograde to deorb:prograde - 0.1.
}
if addons:tr:hasimpact = false { print "Trajectories error". wait until false.}
set addons:tr:retrograde to true.
until (addons:tr:impactpos:lng + 39.8) < 5 AND (addons:tr:impactpos:lng + 39.8) > 0 {
    set deorb:time to deorb:time - 1.
}}
runpath("1:/gen_launch.ks").
lock steering to ship:retrograde.
lko_deorb().
set nd to nextNode.
kuniverse:timewarp:warpto(nd:time  - 60).
print "Deorbiting.".
wait until time > nd:time -5.
lock throttle to 1.
wait until ship:periapsis < 10000.
lock throttle to 0.
remove nd.
wait 0.5.
set kuniverse:timewarp:warp to 2.
wait until ship:altitude < 50100.
kuniverse:timewarp:cancelwarp().
wait until ship:altitude < 50000.
lock steering to ship:srfretrograde.
stage.
wait until ship:altitude < 2500.
print "Script complete exiting.".
set ship:control:pilotmainthrottle to 0.
unlock steering.
unlock throttle.