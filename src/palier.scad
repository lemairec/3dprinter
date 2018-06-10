include <config.scad>;

$fn = 100;
ecartement = 30;
r_tige = 5.1;
r_vis = 1.5;
e = 4;
e2 = 3;

module palier(h1, h2){
    h = h1+h2;
    difference(){
        hull(){
            cylinder(h, r = r_tige + e2);
            translate([ecartement/2,0,0])cylinder(h, r = r_vis + e2);
            translate([-ecartement/2,0,0])cylinder(h, r = r_vis + e2);
            
        }
        translate([0,0,h1-0.1]) cylinder(h2+2, r = r_tige);
        translate([ecartement/2,0,-1])m3(h+2);
        translate([-ecartement/2,0,-1])m3(h+2);
            
    }
}

module palier_roulement_608(){
    h = 608_h+e;
    difference(){
        hull(){
            cylinder(h, r = 608_r + e2);
            translate([ecartement/2,0,0])cylinder(h, r = r_vis + e2);
            translate([-ecartement/2,0,0])cylinder(h, r = r_vis + e2);
            
        }
        translate([0,0,-1]) cylinder(h+2, r = 5);
        translate([0,0,e]) cylinder(h+2, r = 608_r);
        translate([ecartement/2,0,-1])m3(h+2);
        translate([-ecartement/2,0,-1])m3(h+2);
            
    }
}

module palier_bas(){
    h =9;
    difference(){
        union(){
            hull(){
                cylinder(e, r = r_tige + e2);
                translate([ecartement/2,0,0])cylinder(e, r = r_vis + e2);
                translate([-ecartement/2,0,0])cylinder(e, r = r_vis + e2);
            }
            cylinder(h+2, r = r_tige + e2);
        }
        translate([0,0,-1]) cylinder(h+1, r = r_tige);
        translate([ecartement/2,0,-1])m3(e+2);
        translate([-ecartement/2,0,-1])m3(e+2);
            
    }
}

translate([0,0,0]) palier(2, 8);