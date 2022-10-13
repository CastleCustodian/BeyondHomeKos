//first define an orbit to match createOrbit(inc,e,sma,lan,argPe,mEp,t,body)
set goalorb to createOrbit(5.2,0.005052229,4229222,6.7,0,0,0,ship:body).

lock steering to up.
//draw vectors
set shipvec to vecDraw(
    ship:body:position,
    ship:position,
    RGB(1,0,0),
    "Ship pos",
    1.0,
    true,
    0.2,
    true,
    true
).
set orbvec to vecDraw(
    ship:body:position,
    goalorb:position,
    RGB(1,0,0),
    "Orbit pos",
    1.0,
    true,
    0.2,
    true,
    true
).
set nodevec to vecDraw(
    ship:body:position,
    vcrs(shipvec, orbvec),
    RGB(0,0,1),
    "node?",
    1.0,
    true,
    0.2,
    true,
    true
).

wait until false.