//sub-orbital tour script for the Hexagon Tour Agency
// version 1.0.0
wait until ship:unpacked.
lock steering to up.
wait 2.
stage.
wait 30.
wait until ship:altitude > 50000.
wait until ship:altitude < 50000.
lock steering to ship:srfretrograde.
stage.
wait until ship:altitude < 2500.