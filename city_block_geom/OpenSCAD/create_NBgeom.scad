   
module rooms(wthick = .01){
    translate([wthick/2, wthick/2, wthick/2])cube(10-wthick, false);
    translate([10+wthick/2, wthick/2, wthick/2])cube(10-wthick, false);
    translate([20+wthick/2, wthick/2, wthick/2])cube(10-wthick, false);
    translate([wthick/2, wthick/2, 10+wthick/2])cube(10-wthick, false);
    translate([10+wthick/2, wthick/2, 10+wthick/2])cube(10-wthick, false);
    translate([20+wthick/2, wthick/2, 10+wthick/2])cube(10-wthick, false);
}

module windows(extend = .01){
    translate([5,5,10])cube([5,5,20+2*extend], true);
    translate([15,5,10])cube([5,5,20+2*extend], true);
    translate([25,5,10])cube([5,5,20+2*extend], true);
    translate([15,5,5])cube([30+2*extend,5,5], true);
    translate([15,5,15])cube([30+2*extend,5,5], true);
}

module house(wthick = .01){
    difference(){
        cube([30,10,20], false);
        rooms();
        windows();
    }
}

module domain(size=[160,160,160], offest=[5,5,0]){
    translate(offest)cube(size, false);
}


house(.01){}