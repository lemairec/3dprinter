include <config.scad>

$fn=20;

difference(){
    union(){
        translate([-35, -30, 0]) cube([70, 30, 20]);
        translate([-13.5, 0, 0]) cube([10, 40, 20]);
        translate([3.5, 0, 0]) cube([10, 40, 20]);
        translate([-10, 20, 0]) cube([15, 20, 20]);
    }
    translate([-30, -5, -1]) cylinder(22, r3, r3);
    translate([30, -5, -1]) cylinder(22, r3, r3);
    translate([-30, -15, -1]) cylinder(22, r3, r3);
    translate([30, -15, -1]) cylinder(22, r3, r3);
    translate([-30, -25, -1]) cylinder(22, r3, r3);
    translate([30, -25, -1]) cylinder(22, r3, r3);
    translate([-20, 10, 10]) rotate([0, 90, 0]) cylinder(40, 3.2, 3.2);
}