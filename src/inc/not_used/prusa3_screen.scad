include <config.scad>

$fn=100;

dy = 5;

l = 165;
lg = 67;

difference(){
    union(){
        translate([0, 0, 0])cube([l, lg, 2]);
        
        translate([0, lg, 0]) cube([l, 3, 20]);
        
        translate([10, dy, 0]) cylinder(6, r=5);
        translate([10 + 145, dy, 0]) cylinder(6, r=5);
        translate([10, dy+50, 0]) cylinder(6, r=5);
        translate([10 + 145, dy+50, 0]) cylinder(6, r=5);
    }
    translate([10, dy, -1]) m3(10);
    translate([10 + 145, dy, -1]) m3(10);
    translate([10, dy+50, -1]) m3(10);
    translate([10 + 145, dy+50, -1]) m3(10);
    
    translate([10 + 14, dy+58, -1]) m3(10);
    translate([10 + 107, dy+58, -1]) m3(10);
    
    translate([10 + 10, dy+10, -1])cube([100, 42, 10]);
    translate([10 + 20, dy+2, -1])cube([45, 3, 10]);
    
    translate([10 + 135, dy + 8, -1])cylinder(10, r=7);
    //translate([10 + 10, dy + 28, -1])cylinder(10, r=4);
    translate([10 + 135 -7, dy + 28 - 7, -1]) cube([14, 14, 10]);
    translate([10 + 135, dy + 45, -1])cylinder(10, r=7);
        
    translate([15, 10, 12]) rotate([-90,0,0]) m3(200);
    translate([l/2, 10, 12]) rotate([-90,0,0]) m3(200);
    translate([l-15, 10, 12]) rotate([-90,0,0]) m3(200);
}