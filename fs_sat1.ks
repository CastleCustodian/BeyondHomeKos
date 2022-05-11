//flight script for zaltonic satalite 1
//version 1.0

//contract parameters
//new probe with antenna and power gen
//Orbit Specifics:
//Apoapsis:  4,250,589 meters
//Periapsis: 4,207,855 meters
//Inclination: 5.2 degrees
//Longitude of Ascending Node: 6.7 degrees

copypath ("0:/gen_launch.ks","").
copypath ("0:/lib_manuvers.ks","").
runOncePath ("1:/lib_manuvers.ks").
runpath ("1:/gen_launch.ks").

