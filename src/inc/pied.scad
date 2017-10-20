include <../config.scad>

e = 6.8;

module pied(){
    difference(){
        union(){
            cylinder(r=20, 5+5);
            translate([-14, -5, 5])cube([2, 10, 15]);
        }
        translate([-12, -25, 5])cube([e, 50, 50]);
        rotate([0,0,90]) translate([-12, -40, 5])cube([e, 50, 50]);
        translate([-15, 0, 15]) rotate([0,90,0]) m3(10);
    }
}

translate([50,0,0])mirror([1,0,0])pied();
pied();