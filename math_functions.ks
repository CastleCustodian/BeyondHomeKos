//math functions
//Joshua Higginbotham

function semi_axis_calc {
    parameter apo.
    parameter peri.
    set sma to (apo+peri)/2.
    return sma.
}
function ecc_calc {
    parameter apo.
    parameter peri.
    set ecc to (apo-peri)/(apo+peri).
    return ecc.
}
function calc_normal {
    parameter orb_item.

    return vcrs(orb_item:velocity:orbit:normalized, (orb_item:body:position - orb_item:position):normalized):normalized.
}
function calc_lan_vec {
    parameter norm_vec.
    return vCrs(v(0,1,0), norm_vec):normalized.
}
