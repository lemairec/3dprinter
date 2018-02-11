include <../config.scad>
include <../other/jhead.scad>

epaisseur = 3;
vis_fan = 16;

$fn = 30;
r_glissiere = r3;

module fixation_greg_wade(h, l = 0){
    difference(){
        translate([-30, 0, 0])cube([60, 22 + l, h]);
        
        translate([-25, 15 + l, -1]) m3(10);
        translate([25, 15 + l, -1]) m3(10);
        translate([0, 15 + l, -1]) demi_glissiere(9, 10, 10);       
    } 
}

jhead_d = 25;
fan_h0 = 7.5; //8 before
fan_h1 = 40;
fan_h = fan_h0 + fan_h1;
fan_d = 32;

module ventilateur_principal(){
    union(){
        fixation_greg_wade(3, 0);
        translate([-10, 0, fan_h0 + fan_d + 3]) cube([20, 5, 5]);
        
        difference(){
            union(){
                hull(){
                    translate([0, 15, 0])cylinder(fan_h, jhead_d/2+2, jhead_d/2+2);
                    translate([-20, 0, 0]) cube([40, 4, fan_h- 10]);
                    translate([fan_d/2 , 4, fan_h0 + fan_d + 4]) rotate([90, 0, 0])cylinder(4,r=4);
                    translate([-fan_d/2, 4, fan_h0 + fan_d + 4]) rotate([90, 0, 0])cylinder(4,r=4);
                }
                //translate([22, 0, 11]) rotate([-90, 0, 0]) cylinder(12.5, 5, 5);
            }
            hull(){
                //translate([0, 15, fan_h0]) cylinder(40, jhead_d/2, jhead_d/2);
                translate([-jhead_d/2, 15, fan_h0 - 8]) cube([jhead_d, 0.1, 40]);
                translate([0, 3, fan_h0 + 20])  rotate([90, 0, 0])cylinder(4, 36/2, 36/2);
            }
            //translate([22, -1, 11]) rotate([-90, 0, 0]) cylinder(15, r3, r3);
            
            translate([-20, 15, -5]) cube([40, 40, fan_h+10]);
            translate([0, 15, -1])cylinder(fan_h + 2, jhead_d/2, jhead_d/2);
            translate([fan_d/2, 20, fan_h0 + 4])  rotate([90, 0, 0])cylinder(22, r3, r3);
            translate([-fan_d/2, 20, fan_h0 + 4])  rotate([90, 0, 0])cylinder(22, r3, r3);
            translate([fan_d/2, 20, fan_h0 + fan_d + 4])  rotate([90, 0, 0])cylinder(22, r3, r3);
            translate([-fan_d/2, 20, fan_h0 + fan_d + 4])  rotate([90, 0, 0])cylinder(22, r3, r3);
        }
        
        for(i = [0,1]){
            mirror([i,0,0]) translate([-33, 0, 0]) cube([10, 8, 3]);
            mirror([i,0,0]) translate([-33, 0, 5]) difference(){
                rotate([-90, 0, 0]) cylinder(8, 5, 5);
                translate([0,-1, 0]) rotate([-90, 0, 0]) cylinder(15, r3, r3);
            }
        }
    }
}

module ventilateur_2(){
    difference(){
        union(){
            translate([-20, -20, 0])cube([40, 40, 2]);
            translate([24, -2.5, 4.5]) rotate([-90, 0, 0]) cylinder(5, 4.5, 4.5);
            translate([19, -2.5, 0]) cube([5, 5, 2]);
            hull(){
                cylinder(0.1, 18, 18);
                translate([-5, 0, 20]) cylinder(0.1, 10, 10);
            }
            hull(){
                translate([-5, 0, 20]) cylinder(0.1, 10, 10);
                translate([6, 5, 38]) cylinder(0.1, 3, 3);
                translate([6, -5, 38]) cylinder(0.1, 3, 3);
      
            }
        }
        union(){
            hull(){
                translate([0, 0, -0.1])cylinder(0.1, 17, 17);
                translate([-5, 0, 20]) cylinder(0.1, 9, 9);
            }
            hull(){
                translate([-5, 0, 20]) cylinder(0.1, 9, 9);
                translate([6, 5, 38]) cylinder(0.1, 2, 2);
                translate([6, -5, 38]) cylinder(0.1, 2, 2);
            }
        }
        translate([24, -3, 4.5]) rotate([-90, 0, 0]) cylinder(10, r3, r3);
            
        translate([vis_fan, vis_fan, -2]) cylinder(4, r3, r3);
        translate([vis_fan, -vis_fan, -2]) cylinder(4, r3, r3);
        translate([-vis_fan, vis_fan, -2]) cylinder(4, r3, r3);
        translate([-vis_fan, -vis_fan, -2]) cylinder(4, r3, r3);
    }
}

/*r1 = 18;
r2 = 3;
e = 1;

nbr_trou = 12;
r_trou = 1.2;
angle_trou = 30;*/
r1_fan = 20;

r2_fan = 4;
r3_fan = 3;
dr = 5;

e_r = 0.8;

nbr_trou = 16;
r_trou = 1.7;
angle_trou = 45;

e = 2;
l_in = fan_l_out + 0.5;
lg_in = fan_lg_out + 0.5;
l_out = l_in+2*e;
lg_out = lg_in+2*e;

h_fan = 0.5;
x_fan = 31;
angle = 6;

pt1 = [x_fan, -lg_out/2, h_fan + 1];
pt2 = [x_fan, -lg_in/2, h_fan + 1 +e];

module ventilateur_3(){
    difference(){
        union(){
            translate([0, 0, r2_fan]) rotate_extrude(convexity = 10)
                translate([r1_fan, 0, 0])
                hull(){
                    translate([0, r3_fan-r2_fan, 0])circle(r = r3_fan);
                    translate([dr, 0, 0]) circle(r = r2_fan);
                }
            hull(){
                translate([r1_fan + 3, lg_out/2, r2_fan]) rotate ([90, 0, 0]) cylinder(lg_out, r = r2_fan);
                translate(pt1) rotate([0,-angle,0])cube([0.1, lg_out, l_out]);
                translate([32.9, lg_out/2, 2]) rotate ([90, 0, 0]) cylinder(lg_out, 2, 2);
            }
            translate(pt1) rotate([0,-angle,0])cube([3, lg_out, l_out]);
            
            translate([25, -lg_out/2, 4]) rotate([0, 4, 0]) cube([10, 2, 46]);
            translate([x_fan + 1, -12, h_fan + 50]) rotate ([-90, 0, 0]) cylinder(4, 5, 5);
        }
        translate([0, 0, r2_fan]) rotate_extrude(convexity = 10)
            translate([r1_fan, 0, 0])
            hull(){
                translate([0, r3_fan-r2_fan, 0])circle(r = r3_fan-e_r);
                translate([dr, 0, 0]) circle(r = r2_fan-e_r);
            }
        
        for(i=[0:nbr_trou]){
            rotate([0, 0, (i+ 0.5)*360/nbr_trou]) translate([-r1_fan,0,r3_fan]) rotate([0, 90 + angle_trou, 0]) cylinder(r1_fan, r_trou, r_trou);
        }
        
        translate([x_fan + 1, -12.01, h_fan + 50]) rotate([-90, 0, 0]) m3(10, true);
        %translate([x_fan + 1, -12.01, h_fan + 50]) rotate([-90, 0, 0]) m3(40, true);
        hull(){
            translate([r1_fan + 3, lg_in/2, r2_fan]) rotate ([90, 0, 0]) cylinder(lg_in, r = r2_fan-e_r);
            translate(pt2) rotate([0,-angle,0]) cube([11, lg_in, l_in]);
            
        }
        translate([r1_fan + r3_fan + 10, -2, 1.3]) rotate([0,-angle,0]) translate([0,0, 0]) cube([3, 2, 10]);
    }
    
    %translate([31,-8, 3 + h_fan]) rotate([0,-angle,0]) fan();
    
}

if(false){
    ventilateur_principal();
    %translate([0, 15, 0]) jhead();
    translate([0, 15 ,47 + r2_fan*2 + h_fan]) rotate([180, 0, 0]) ventilateur_3();
    
} else {
    //fan();
    jhead_vis();
    //ventilateur_3();
    //translate([0, -40,0])rotate([90, 0, 0]) ventilateur_principal();
    //%import("/Users/lemairec/Downloads/fan_nozzle_V2.stl");
}
