include <../config.scad>;

e = 3;
e2 = 3;
l = 50;

h = e + e2;
$fn=100;
r = 4;

module cote1(){
    difference(){
        hull(){
            translate([-l/2, 0,0]) cylinder(r = r, h);
            translate([l/2, 0,0]) cylinder(r = r, h);
        }
        translate([-l/2, 0,-1]) m3(h+2);
        translate([l/2, 0,-1]) m3(h+2);
    }
}

module cote2(){
    difference(){
        union(){
            hull(){
                translate([-l/2, 0,0]) cylinder(r = r, e);
                translate([l/2, 0,0]) cylinder(r = r, e);
            }
            translate([-l/2, 0,0]) cylinder(r = r, h);
            translate([l/2, 0,0]) cylinder(r = r, h);
        }
        translate([-l/2, 0,-1]) m3(h+2);
        translate([l/2, 0,-1]) m3(h+2);
    }
}

 cote2();
translate([0, 10]) cote2();