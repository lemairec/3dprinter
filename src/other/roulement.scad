include <../config.scad>;

$fn = 100;

l = 120;
e = 5;
e1= 6;
e2= 7;



r = 17;

//608zz
roulement_r = 8.5/2;
roulement_r1 = 11/2;
roulement_r2 = 23.5/2;

difference(){
    difference(){
        union(){
            hull(){
                translate([-l/2, 0, 0]) cylinder(e, r=r);
                translate([ l/2, 0, 0]) cylinder(e, r=r);
            }
            for(i=[-1,1]){
                translate([i*l/2, 0, 0]) cylinder(e1, r=roulement_r1);
                translate([i*l/2, 0, 0]) difference(){
                    union(){
                        translate([0, 0, e]) cylinder(e2-e, r, roulement_r2+1);
                        cylinder(e, r=r);
                    }
                    translate([0,0,-1])cylinder(e+10, r=roulement_r2);
                }
            }
        }
        translate([-l/2, 0, -1]) cylinder(e+10, r=roulement_r);
        translate([ l/2, 0, -1]) cylinder(e+10, r=roulement_r);
    }
}
