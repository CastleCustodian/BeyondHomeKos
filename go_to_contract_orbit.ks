function include {
    parameter filename.
    copyPath("0:/" + filename, "1:/").
    runOncePath("1:/" + filename).
}

include("math_functions.ks").
include("orb_manuvers.ks").

//define goal orbit
set goal_apo to 4554965.
set goal_peri to 3431482.
set goal_inc to 6.7.
set goal_lan to 153.4.
set goal_argpe to 247.7.
set goal_mep to 0.
set goal_t to 0.
set goal_body to ship:body.
set goal_ecc to ecc_calc(goal_apo, goal_peri).
set goal_sma to semi_axis_calc(goal_apo, goal_peri).
//define an orbit to match goal createOrbit(inc,e,sma,lan,argPe,mEp,t,body)
set goalorb to createOrbit(goal_inc,goal_ecc,goal_sma,goal_lan,goal_argpe,goal_mep,goal_t,goal_body).

set goalorb_normal to calc_normal(goalorb).
set ship_normal to calc_normal(ship).
set orbit_angle to vang(goalorb_normal, ship_normal).
print "inc diff: " + orbit_angle.
until orbit_angle < 0.02 {
    plane_change(goalorb).
    set goalorb_normal to calc_normal(goalorb).
    set ship_normal to calc_normal(ship).
    set orbit_angle to vang(goalorb_normal, ship_normal).
    wait 1.
}
print "Within inclination tolerance.".
print "inc diff:" + orbit_angle.
lock throttle to 0.



//calc true anomaly of lan
set ship_lan_truanom to 360 - ship:orbit:argumentofperiapsis.
set goal_pe_truanom to mod((ship_lan_truanom + goal_argpe), 360).
print "waiting to burn for apo.".
lock steering to ship:prograde.
until ship:orbit:trueanomaly > goal_pe_truanom - 5 and ship:orbit:trueanomaly < goal_pe_truanom + 5 {
    print "true anomaly: " + ship:orbit:trueanomaly.
    print "anomaly of goal pe: " + goal_pe_truanom.
    wait 1. 
}

// orbit matching procdure when sucessfully at right point.
lock steering to prograde.
wait until ship:orbit:trueanomaly > goal_pe_truanom - 0.5 and ship:orbit:trueanomaly < goal_pe_truanom + 0.5.
lock throttle to 1.
wait until ship:orbit:apoapsis > goal_apo - 30.
lock throttle to 0.
wait 1.
set wrptime to time:seconds + ship:obt:eta:apoapsis -90.
kuniverse:timewarp:warpto(wrptime).
lock steering to prograde.
wait until ship:obt:eta:apoapsis < 20.
lock throttle to 1.
wait until ship:orbit:periapsis > goal_peri - 20.
lock throttle to 0.

// until false {
//     set goalorb_normal to calc_normal(goalorb).
//     set goalorb_lan_vec to calc_lan_vec(goalorb_normal).
//     set goalorb_pe_vec to angleAxis(-goal_argpe, goalorb_normal) * goalorb_lan_vec.
//     set ship_vec to ship:body:position.
//     set pe_ang to vang(goalorb_pe_vec, ship_vec).
//     print "pe ang: " + pe_ang.
//     wait 1.
//     }


