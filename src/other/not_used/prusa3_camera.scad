include <../../config.scad>

//20

difference(){
    union(){
        translate([-40,-60,0]) cube([40,15, 15]);
        translate([0,-60,0]) cube([5,120, 15]);
        translate([0,55,0]) cube([30, 5, 15]);
        translate([25,55,0]) cube([5, 45, 15]);
        
        
    }
    translate([20,55 + 15,7.5]) rotate([0, 90, 0]) m8(30);
        translate([20,55 + 35,7.5]) rotate([0, 90, 0]) m8(30);
}