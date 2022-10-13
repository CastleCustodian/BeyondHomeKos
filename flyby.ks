function include {
    parameter filename.
    copyPath("0:/" + filename, "1:/").
    runOncePath("1:/" + filename).
}

include("math_functions.ks").
include("orb_manuvers.ks").

//define goal orbit
set goal_body_name to "Lua".
set goal_body to body(goal_body_name).
//define an orbit to match goal createOrbit(inc,e,sma,lan,argPe,mEp,t,body)
set goalorb to goal_body:orbit.

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

//save state since rest of script is experimental
wait until kuniverse:canquicksave.
kuniverse:quicksave().


//calculate transfer time
set transfer_sma to semi_axis_calc(ship:orbit:semimajoraxis, goalorb:semimajoraxis).
set transfer_time to constant:PI * SQRT(transfer_sma^3 / ship:body:Mu).
//calculate phase angle of transfer
set goalorb_degrees_per_second to 360 / goalorb:period.
set target_transfer_angle to transfer_time * goalorb_degrees_per_second.
set transfer_phase_angle to target_transfer_angle + 180.
//calc how fast we move
set ship_speed_deg to 360 / ship:orbit:period.
//calc current phase angle
set cur_time to  time:seconds.
set cur_ship_angle to vang((goal_body:position - ship:body:position), -ship:body:position).
set ship_angle_cross to vcrs((goal_body:position - ship:body:position), -ship:body:position).
set ship_normal to calc_normal(ship).
set dotcalc to vdot(ship_angle_cross, ship_normal).
set cur_phase_angle to cur_ship_angle.
//subtract from 360 if object is behind us
if dotcalc < 0 {
    set cur_phase_angle to (360 - cur_ship_angle).
}
//calc when to burn
set rel_speed to ship_speed_deg - goalorb_degrees_per_second.
set phase_diff to transfer_phase_angle - cur_phase_angle.
if phase_diff < 0 {
    set phase_diff to 360 + (transfer_phase_angle - cur_phase_angle).
}
set time_to_transfer to phase_diff / rel_speed.
set time_of_transfer to time_to_transfer + cur_time.
//calculate dv needed
set transfer_dv to sqrt(ship:body:mu * ((2 / (ship:altitude + ship:body:radius)) - (1 / transfer_sma))) - ship:velocity:orbit:mag.
//create manuver node
set transfer_node to node(time_of_transfer, 0, 0, transfer_dv).
add transfer_node.
