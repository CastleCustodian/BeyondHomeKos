copypath ("0:/gen_launch.ks", "1:/").
copypath ("0:/go_to_contract_orbit.ks", "1:/").
print "Running launch program.".
runpath ("1:/gen_launch.ks").
wait 1.
print "Running go to orb program.".
runpath ("1:/go_to_contract_orbit.ks").
wait 10.
print "Contract complete! removing uneccessacary programs.".
deletepath ("1:/gen_launch.ks").
deletepath ("1:/go_to_contract_orbit.ks").