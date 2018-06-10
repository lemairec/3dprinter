include <../config.scad>;

608_r = 22.3/2;
608_h = 8;

roulement_h = 29;
roulement_r = 19.2/2;

bobine_h = 85;
bobine_r = 50/2;
bobine_r2 = 35/2;


r_int= 15/2;

e=2;
$fn=100;
support_e = 0.3;

module bobine_roulement(){
    difference(){
        union(){
            cylinder(bobine_h+2*e, r= bobine_r2);
            for(i = [0, bobine_h+e]){
                translate([0,0,i])cylinder(e, r= bobine_r);
            }
            
        }
        translate([0,0,-1])cylinder(bobine_h+4*e, r=r_int);
        for(i = [-1,bobine_h+2*e-roulement_h]){
            translate([0,0,i])cylinder(roulement_h+1, r=roulement_r);
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
    translate([0,0,roulement_h])cylinder(support_e, r= roulement_r);
}


translate([0,0,0]) bobine_roulement();
support();