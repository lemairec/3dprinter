include <../config.scad>

h = 10;
e1 = 10;
e = 3;

l = 140;
lg = 151;

difference(){
    union(){
        hull(){
            translate([-lg/2-e1, 8-e, 0])cylinder(e, r=8);
            translate([+lg/2+e1, 8-e, 0])cylinder(e, r=8);
        }
        translate([-lg/2-e, -e,0]) cube([lg+2*e, e, h]);
        for(i = [0,1]){
            mirror([i,0,0])translate([lg/2, -e,0]) cube([ e, l+e, h]);
            mirror([i,0,0])translate([-lg/2- e, -e,0]) cube([ h, l+e, e]);
            
            mirror([i,0,0]) translate([lg/2, l-e, 0]) hull(){
                cube([ e, e, h]);
                translate([h, 0, h/2]) rotate([-90,0,0])cylinder(e, r=h/2);
            }
        }
        
    }
    translate([-lg/2-e1, 8-e, -1])cylinder(e+2, r=4);
    translate([+lg/2+e1, 8-e, -1])cylinder(e+2, r=4);
    %translate([-lg/2, 0, e]) cube([lg, l, 100]);
    for(i = [0,1]){
        mirror([i,0,0]) translate([lg/2, l-e, 0]) translate([h, 0, h/2]) rotate([-90,0,0])cylinder(e, r=2);
    }
}
