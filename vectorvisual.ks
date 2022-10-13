//vector visualize
lock steering to up.
//first define an orbit to match createOrbit(inc,e,sma,lan,argPe,mEp,t,body)
set goalorb to createOrbit(20.9,0.278574626191509,5721453,77.5,339.8,0,0,ship:body).
wait 5.
function calc_normal {
    parameter orb_item.

    return vcrs(orb_item:velocity:orbit:normalized, (orb_item:body:position - orb_item:position):normalized):normalized.
}
set goalorb_normal to calc_normal(goalorb).
set ship_normal to calc_normal(ship).
set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
set goalorb_normal_arrow to vecdraw(
    v(0,0,0),
    goalorb_normal,
    rgb(0,1,0),
    "Goal Normal",
    50,
    true,
    1,
    true,
    true
).
set ship_normal_arrow to vecdraw(
    v(0,0,0),
    ship_normal,
    rgb(0,1,0),
    "Goal Normal",
    50,
    true,
    1,
    true,
    true
).set node_vec_arrow to vecdraw(
    v(0,0,0),
    node_vec,
    rgb(0,1,0),
    "Goal Normal",
    50,
    true,
    1,
    true,
    true
).

set x to 1.

until x > 5 {
    set goalorb_normal to calc_normal(goalorb).
    set ship_normal to calc_normal(ship).
    set node_vec to vcrs(goalorb_normal, ship_normal):normalized.
    


    wait 5.
}

