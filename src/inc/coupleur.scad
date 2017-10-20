include <config.scad>;

$fn = 100;
module coupleur(){
    difference(){
        cube_arrondi(30,30,6);
        
        translate([0.5,0,-0.5]) rotate([0,90,0]) cylinder(r=5/2, 100);
        translate([-0.5,0,-0.5]) rotate([0,-90,0]) cylinder(r=8/2, 100);
        
        for(i=[-1,1]){
            for(j=[-1,1]){
                translate([i*10,j*10, -1]) m3(10);
            }
        }
    }
}

coupleur();