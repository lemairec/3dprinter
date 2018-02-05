include <../config.scad>;

608_r = 22.3/2;
608_h = 8;
bobine_h = 85;
bobine_r = 45/2;
e=2;
$fn=100;
support_e = 0.25;

module bobine_roulement(){
    difference(){
        union(){
            cylinder(bobine_h+2*e, r= 608_r+e);
            for(i = [0, bobine_h+e]){
                translate([0,0,i])cylinder(e, r= bobine_r);
            }
            
        }
        translate([0,0,-1])cylinder(bobine_h+4*e, r=8);
        for(i = [-1,bobine_h+2*e-608_h]){
            translate([0,0,i])cylinder(608_h+1, r=608_r);
        }
    }
}

module support(){
    difference(){
        cylinder(bobine_h+2*e, r=bobine_r);
        translate([0,0,-1])cylinder(bobine_h+3*e, r=bobine_r-support_e);   
    }
    translate([0,0,bobine_h+e-1])difference(){
        cylinder(2, r=bobine_r+1.5);
        translate([0,0,-1])cylinder(bobine_h+3*e, r=bobine_r-support_e);   
    }
    translate([0,0,608_h])cylinder(support_e, r= 608_r);
}


translate([0,0,0]) bobine_roulement();
//support();