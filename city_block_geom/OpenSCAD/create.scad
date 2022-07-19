   
module domain(size=[160,160,160], offest=[5,5,0]){
    translate(offest)cube(size, false);
}

module building_set(no_dupes=true, offset=[0,0,0]) {;
    translate(offset){
        if(no_dupes) {
            intersection() {
                cube([80,80,20], false);
                import(   "/home/nbachand/Documents/Cascade/city_block/city_block_geom/cube_array.stl", convexity = 4);
            }
        }
        else {
            import(   "/home/nbachand/Documents/Cascade/city_block/city_block_geom/cube_array.stl", convexity = 4);
        }
    }
}

module buildings() {
    building_set();
    building_set(no_dupes = false, offset = [80,80,0]);
    building_set(no_dupes = false, offset = [0,80,0]);
    building_set(no_dupes = false, offset = [80,0,0]);
}

rotate([90,0,0]){
    mirror([0,0,1]){
        difference(){
            domain();
            buildings();
        }
    }
}
