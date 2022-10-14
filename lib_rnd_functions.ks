function include {
    parameter filename.
    copyPath("0:/" + filename, "1:/").
    runOncePath("1:/" + filename).
}