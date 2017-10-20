include <config.scad>

e =3;

module z_stop(){
    vis_ecart = 30;
    h = 15;
    difference(){
        union(){
            hull(){
                translate([-vis_ecart/2, 0, 0]) cylinder(e, r = 5);
                translate([vis_ecart/2, 0, 0]) cylinder(e, r = 5);
            }
            translate([-10, 3.5, 0])cube([20,4,h+4]);
        }
        translate([-vis_ecart/2, 0, -1]) m3(10);
        translate([vis_ecart/2, 0, -1]) m3(10);
        
        translate([-10/2, 0, h]) rotate([-90,0,0]) cylinder(30, r= 3/2);
        translate([10/2, 0, h]) rotate([-90,0,0]) cylinder(30, r= 3/2);
    }
}

z_stop();
//z_ecrou();
//xy(120);

//corner();
//translate([0,2*lg_xy+4,0])middle2();
