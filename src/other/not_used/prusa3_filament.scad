include <config.scad>

h = 3;
l = 40;
 $fn=100;
 
rayon = 16;
rayon2 = 5;
l = 80;

difference(){
    union(){
        translate([-40, 0, 0]) cube([80, 4, 20]);
        translate([0,l,rayon2-1]) rotate_extrude() translate([rayon,0,0]) circle (rayon2);

        hull(){
            translate([rayon,l,rayon2-1]) rotate([90, 0, 0]) cylinder(2, rayon2, rayon2);
            translate([30, 0, 0])cube([10, 3, 15]);
        }

        hull(){
            translate([-rayon,l,rayon2-1]) rotate([90, 0, 0]) cylinder(2, rayon2,rayon2);
            translate([-30-10, 0, 0])cube([10, 3, 15]);
        }
     }
     translate([-100, 0, -20]) cube([200, 200, 20]);
     translate([-20,10,14]) rotate([90, 0, 0]) cylinder(20, r4, r4);
     translate([20,10,14]) rotate([90, 0, 0]) cylinder(20, r4, r4);
}