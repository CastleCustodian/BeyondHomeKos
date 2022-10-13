function exc_node {
    local nd to nextNode.
    if nd:deltav:mag > SHIP:STAGEDELTAV(SHIP:stagenum):current { 
        print "Not enough fuel please end program".
        wait until false.
        }
    print "adjusting heading.".
    local np to nd:deltav.
    lock steering to np.
    local max_acc to ship:maxthrust/ship:mass.
    local burn_duration to nd:deltav:mag/max_acc.
    local tadj to 1.
    // local ext_burn to true.
    if burn_duration < 3 { 
        set burn_duration to 3. 
        // calculate thrust required for slower burn
        set tadj to (ship:mass * nd:deltav:mag / 3) / ship:maxthrust.
        // don't think this is necessary
        // set max_acc to  nd:deltav / 3.
        // set ext_burn to false.
    }
    
    wait until vang(ship:facing:forevector, np) < 0.1.
    if time < nd:time - (burn_duration/2) - 90 {
    print "warping.".
    kuniverse:timewarp:warpto(nd:time - (burn_duration/2) - 30).
    wait until nd:eta <= (burn_duration/2).
    
    local tset to 0.
    lock throttle to tset.
    local done to false.
    local dv0 to nd:deltav.
    print tadj.
    until done {
        set max_acc to ship:maxthrust/ship:mass.
        set tset to min((nd:deltav:mag/max_acc), (1*tadj)).

        if vdot(dv0, nd:deltav) < 0 {
            print "End burn, remain dv " +round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
            lock throttle to 0.
            break.
        }

            if nd:deltav:mag < 0.1
    {
        print "Finalizing burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
        //we burn slowly until our node vector starts to drift significantly from initial vector
        //this usually means we are on point
        wait until vdot(dv0, nd:deltav) < 0.5.

        lock throttle to 0.
        print "End burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
        set done to True.
    }
    }
    unlock steering.
    unlock throttle.
    wait 1.
    remove nd.
    set ship:control:pilotmainthrottle to 0.
}
}
exc_node().