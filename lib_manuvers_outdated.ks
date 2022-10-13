//orbital manuver library file
//Joshua Higginbotham
//Version 1.0.0

//orbit locations in (lat,lng,time)

declare global function obtPlaneDiff {
    wait 0.01. //new tick
    parameter orbitone.
    parameter orbittwo.
    declare local inci is orbitone:inclination.
    declare local lani is orbitone:longitudeofascendingnode.
    declare local incf is orbittwo:inclination.
    declare local lanf is orbittwo:longitudeofascendingnode.
    declare local a1 is sin(inci)*cos(lani).
    declare local a2 is sin(inci)*sin(lani).
    declare local a3 is cos(inci).
    declare local b1 is sin(incf)*cos(lanf).
    declare local b2 is sin(incf)*sin(lanf).
    declare local b3 is cos(incf).
    declare local theta is arccos(a1*b1+a2*b2+a3*b3).
    declare local c1 is a2*b3-a3*b2.
    declare local c2 is a3*b1-a1*b3.
    declare local c3 is a1*b2-a2*b1.
    declare local degvar is 90.
    if c1 > 0 {set degvar to 270.}
    if c1 = 0 {print "angle coords undefined.". return list(theta,0,0).}
    // these are in cellestial coords I think
    declare local lat1 is arctan(c3/sqrt(c1^2+c2^2)).
    declare local long1 is arctan(c2/c1)+ degvar. //90deg if c1<0 270deg if c1>0
    //declare local lat2 is -lat1.
    //declare local long2 is mod(long1+180, 360).
    return list(theta,lat1,long1).
    }

//Homann transfer function
declare global function basic_Hohmann_txfr { 
    parameter desiredalt.
}