include <../config.scad>

e = 6.5;

module pied(){
    difference(){
        union(){
            cylinder(r=20, 5+5);
            translate([4+e, -5, 5])cube([4, 10, 15]);
        }
        translate([4, -25, 5])cube([e, 50, 50]);
        rotate([0,0,-90]) translate([4, -41, 5])cube([e, 50, 50]);
        translate([-15, 0, 15]) rotate([0,90,0]) m3(100);
    }
}

translate([50,0,0])mirror([1,0,0])pied();
pied();