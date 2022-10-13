
list bodies in listbods.

log listbods to bodlist.txt.
copypath("1:/bodlist.txt", "0:/").

listbods:remove(0).
log ("Name, description, mass, has ocean, has solid surface, altitude, rotation period, radius, mu, soi radius, apoapsis, periapsis, period, inclination, eccentricity, LAN") to orbparam.csv.
for each in listbods {
    set bod to each.
log (bod:name+", '"+bod:description+"', "+bod:mass+", "+bod:hasocean+", "+bod:hassolidsurface+", "+bod:altitude+", "+bod:rotationperiod+", "+bod:radius+", "+bod:mu+", "+bod:soiradius+", "+bod:orbit:apoapsis+", "+bod:orbit:periapsis+", "+bod:orbit:period+", "+bod:orbit:inclination+", "+bod:orbit:eccentricity+", "+bod:orbit:LAN) to orbparam.csv.
}
copypath("1:/orbparam.csv", "0:/").