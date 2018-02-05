include <../config.scad>

fan_40_d = 31;
module fan_40(){
    difference(){
        hull(){
            for(i=[-1,1]){
                translate([i*fan_40_d/2, 0, -fan_40_d/2])  rotate([-90, 0, 0])cylinder(12, r=3);
                translate([i*fan_40_d/2, 0, +fan_40_d/2])  rotate([-90, 0, 0])cylinder(12, r=3);
            }
        }
        for(i=[-1,1]){
            translate([i*fan_40_d/2, -1, -fan_40_d/2])  rotate([-90, 0, 0])m3(14);
            translate([i*fan_40_d/2, -1, +fan_40_d/2])  rotate([-90, 0, 0])m3(14);
        }
        translate([0, -1, 0]) rotate([-90, 0, 0]) cylinder(20, r = 15);
    }
}

fan_radial_l_out = 20;
fan_radial_lg_out = 15;
fan_radial_l_in = 17.5;
fan_radial_lg_in = 13;
fan_radial_r= 49/2;


module fan_radial(){
    difference(){
        union(){
            translate([0,6,-2])cube([10, 2, 2]);
            cube([30, fan_radial_lg_out, fan_radial_l_out]);
            translate([fan_radial_r + 3, 0, fan_radial_r + 2]) rotate([-90, 0, 0]) cylinder(15, r = fan_radial_r);
            hull(){
                translate([7, 0, 47]) rotate([-90, 0, 0]) cylinder(15, r = 3.5);
                translate([45, 0, 4]) rotate([-90, 0, 0]) cylinder(15, r = 3.5);
            }
        }
        translate([7, -1, 47]) rotate([-90, 0, 0]) m3(20);
        translate([45, -1, 4]) rotate([-90, 0, 0]) m3(20);
    }
}

module support_fan_radial(){
    h_fan = 2;
    e_fan = 1;
    e = 4;
    difference(){
        union(){
            translate([-25,0,0])cube([70,e,15+2*e_fan]);
            translate([-12,0,0])cube([10,50+h_fan,e_fan]);
            translate([33,0,0])cube([10,12+h_fan,e_fan]);
        }
        translate([-10,h_fan,e_fan]) rotate([90, 0, 90])fan_radial();
        translate([-10,-1,e_fan]) rotate([90, 0, 90])cube([5,15,20]);
        translate([-6,h_fan+45,-1]) m3(10);
        translate([38,h_fan+7,-1]) m3(10);
        translate([-20,-1,e_fan+7.5]) rotate([-90,0,0])m3(10);
        translate([20,-1,e_fan+7.5]) rotate([-90,0,0])m3(10);
        translate([20,2,e_fan+7.5]) rotate([-90,0,0])nut(3);
        translate([-20,2,e_fan+7.5]) rotate([-90,0,0])nut(3);
    }
    %translate([-10,h_fan,e_fan]) rotate([90, 0, 90])fan_radial();
}

support_fan_radial();