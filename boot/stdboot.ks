wait until ship:unpacked.
if career():candoactions {
core:doaction("Open Terminal", true).
}
if homeConnection:isconnected { 
    if exists ("0:/update.ks"){
        copypath ("0:/update.ks", "1:/").
        deletepath ("0:/update.ks").
        runpath ("1:/update.ks").
        deletePath ("1:/update.ks").    
    }
}
if exists ("1:/startup.ks") { runpath ("1:/startup.ks").}
print "Waiting for connection to update.".
until false {
    wait 10.
    if homeConnection:isconnected { 
    if exists ("0:/update.ks"){
        copypath ("0:/update.ks", "1:/").
        runpath ("1:/update.ks").
        deletePath ("1:/update.ks").
        break.
    }
}
}
print "Startup script and or update has been run nothing else to do.".