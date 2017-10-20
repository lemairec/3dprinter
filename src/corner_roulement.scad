include <config.scad>;

$fn = 100;
e = 2.5;
l1=20+e;
l2 = l1 + 20;
h=17 + 2*e;
    
module corner_roulement(){
    difference(){
        union(){
            cube_arrondi(h, l2, e);
            mirror([1,0,0])translate([-h/2, -l1/2, 0]) cube([e, h, l1]);
            translate([-h/2, -l1/2, 0]) cube([e, h, l1]);
            translate([-h/2, -l1/2, 0]) cube([h, e, l1]);
        }
        translate([-15, 0, 12 +e]) rotate([0,90,0]) m3(30, center = true);
        
        translate([0, -(l2/2 -5),-1]) m3(10);
        translate([0, l2/2 -5,-1]) m3(10);
    }
}


translate([15,0,0]) corner_roulement();
translate([-15,0,0]) corner_roulement();