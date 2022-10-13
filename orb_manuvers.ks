//orbital manuvers
//Joshua Higginbotham


function plane_change {
    //acceptes any kos orbit structure
    //assumes that you are currently in a circular orbit
    parameter goalorb.

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
    // wait until you are 10 seconds from the node
    until orbit_pos < ((10 / ship:orbit:period) * 360) {
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        print "pos: " + orbit_pos + " Ang: " + orbit_angle.
        wait 1.
    }
    lock throttle to min(1,(orbit_angle / 2)).
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