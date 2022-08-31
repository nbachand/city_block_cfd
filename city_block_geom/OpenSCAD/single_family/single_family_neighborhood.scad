   
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

module roof(){
polyhedron(
  points=[ [0,10,0],[30,10,0],[30,10,20],[0,10,20], // the four points at base
           [15,20,10]  ],                                 // the apex point 
  faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],              // each triangle side
              [1,0,3],[2,1,3] ]                         // two triangles for square base
 );
}

module house(wthick = .01, interior = false){
    union(){
        difference(){
            cube([30,10,20], false);
            if(interior){
                rooms();
                windows();
                }
        }
        roof();
    }
}

module house_row(num_houses = 12, i_interior = -1){
    for(i=[0:num_houses-1]){
        interior = i==i_interior ? true : false;
        translate([5+i*40,0,0])house(interior = interior);
    }
}

module neigborhood(grid_size = [12,8], cord_interior = [0,0]){
    for(k=[0:grid_size[1]-1]){
        i_interior = k==cord_interior[1] ? cord_interior[0] : -1;
        one_odd = k%2;
        x_offset = one_odd*-20;
        translate([x_offset,0,20+k*60])house_row(grid_size[0]+one_odd, i_interior=i_interior);
    }
}

module domain(size=[480,480,480], offest=[0,0,0]){
    translate(offest)cube(size, false);
}

difference(){
    domain();
    neigborhood([12,8], [6,4]);
}