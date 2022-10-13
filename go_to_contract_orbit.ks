function semi_axis_calc {
    parameter apo.
    parameter peri.
    set sma to (apo+peri)/2.
    return sma.
}
function ecc_calc {
    parameter apo.
    parameter peri.
    set ecc to (apo-peri)/(apo+peri).
    return ecc.
}
function calc_normal {
    parameter orb_item.

    return vcrs(orb_item:velocity:orbit:normalized, (orb_item:body:position - orb_item:position):normalized):normalized.
}
function calc_lan_vec {
    parameter norm_vec.
    return vCrs(v(0,1,0), norm_vec):normalized.
}

function plane_change {
    //get ready for plane change
    //calculate relevant vectors 
    set goalorb_normal to calc_normal(goalorb).
    set ship_normal to calc_normal(ship).
    set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
    set orbit_pos to vang(ship:body:position, node_vec).
    set orbit_angle to vang(goalorb_normal, ship_normal).
    lock steering to ship_normal.
    wait until vang(ship_normal,ship:facing:forevector) < 1.
    //warp to plane change
    print "Warping to node for plane change.".
    set kuniverse:timewarp:rate to 100.
    until orbit_pos > 21{
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        wait 0.1.
    }
    until orbit_pos < 20{
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        wait 0.1.
    }
    set kuniverse:timewarp:rate to 10.
    until orbit_pos < 3{
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        wait 0.1.
    }
    kuniverse:timewarp:cancelwarp().
    until orbit_pos < 1 {
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        print "pos: " + orbit_pos + " Ang: " + orbit_angle.
        wait 1.
    }
    lock throttle to 1.
    until orbit_pos > 2 or orbit_angle < 1 {
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        print "pos: " + orbit_pos + " Ang: " + orbit_angle.
        wait 0.1.
    }
    lock throttle to 0.1.
    until orbit_pos > 1 or orbit_angle < 0.01 {
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        print "pos: " + orbit_pos + " Ang: " + orbit_angle.
        wait 0.1.
    }
    lock throttle to 0.
}

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
    plane_change().
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


