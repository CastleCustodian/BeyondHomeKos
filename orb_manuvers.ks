//orbital manuvers
//Joshua Higginbotham


function plane_change {
    //acceptes any kos orbit structure
    parameter goalorb.

    //check if you are currently in a circular enough orbit and error out if not
    if ship:orbit:eccentricity > 0.05 {
        print "error ship is not in a circular enough orbit halting.".
        until false {
            wait 60.
        }
    }

    //get ready for plane change
    //calculate relevant vectors 
    set goalorb_normal to calc_normal(goalorb).
    set ship_normal to calc_normal(ship).
    set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
    set orbit_pos to vang(ship:body:position, node_vec).
    set orbit_angle to vang(goalorb_normal, ship_normal).
    wait 1.
    set orbit_pos_check to vang(ship:body:position, node_vec).
    set orbit_pos_full to orbit_pos.
    if orbit_pos_check > orbit_pos {
        set orbit_pos_full to orbit_pos + 180.
    }
    set wrptime to (orbit_pos_full * ship:orbit:period / 360) - 90.
    lock steering to ship_normal.
    wait until vang(ship_normal,ship:facing:forevector) < 1.
    print "Warping to node for plane change.".
    kuniverse:timewarp:warpto(wrptime).
    // wait until you are 10 seconds from the node
    until orbit_pos < ((10 / ship:orbit:period) * 360) {
        set goalorb_normal to calc_normal(goalorb).
        set ship_normal to calc_normal(ship).
        set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
        set orbit_pos to vang(ship:body:position, node_vec).
        set orbit_angle to vang(goalorb_normal, ship_normal).
        wait 1.
    }
    print "Correcting inclination.".
    print "inc diff at start: " + orbit_angle.
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
    print "That's all for this pass.".
    print "inc diff now: " + orbit_angle.
}