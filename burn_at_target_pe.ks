lock steering to ship:prograde.
//first define an orbit to match createOrbit(inc,e,sma,lan,argPe,mEp,t,body)
set goalorb to createOrbit(20.9,0.278574626191509,5721453,77.5,339.8,0,0,ship:body).
wait 2.
function calc_normal {
    parameter orb_item.

    return vcrs(orb_item:velocity:orbit:normalized, (orb_item:body:position - orb_item:position):normalized):normalized.
}
clearvecdraws().
wait 2.
until mod(ship:orbit:trueanomaly + ship:orbit:argumentofperiapsis,360) - goalorb:argumentofperiapsis < 1 and mod(ship:orbit:trueanomaly + ship:orbit:argumentofperiapsis,360) - goalorb:argumentofperiapsis > -1{
    print (mod(ship:orbit:trueanomaly + ship:orbit:argumentofperiapsis,360) - goalorb:argumentofperiapsis).
    wait 1.
}
lock throttle to 1.
wait until ship:orbit:apoapsis > 11422900.
lock throttle to 0.


