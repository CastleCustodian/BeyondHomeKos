wait until ship:unpacked.
clearscreen.
wait 60.
lock steering to heading(90,80).
print "Begin countdown".
wait 1.
print "10...".
wait 1.
print "9...".
wait 1.
print "8...".
wait 1.
print "7...".
wait 1.
print "6...".
wait 1.
print "5...".
wait 1.
print "4...".
wait 1.
print "3...".
wait 1.
print "2...".
wait 1.
print "1...".
wait 1.
print "Liftoff...".
stage.
wait 30.
unlock steering.
wait until ship:altitude > 60000.
stage.
wait until ship:altitude < 59000.
lock steering to retrograde.
wait until ship:altitude < 2500.
unlock steering.