include <../config.scad>
include <../inc/fan.scad>

fan_nut_x = 17;
e_fan = 2;
    
module support_fan_radial(){
    h_fan = 2;
    e = 4;
    difference(){
        union(){
            translate([-25,-7.5-e_fan,0])cube([70,15+2*e_fan,e]);
            translate([-12,7.5,0])cube([10,e_fan,50+h_fan]);
            translate([33,7.5,0])cube([10,e_fan,12+h_fan]);
        }
        translate([-10,7.5,h_fan]) rotate([0, -90, 180])fan_radial();
        translate([-10,-7.5,-10]) cube([20,15,100]);
        translate([-6,-50,h_fan+45]) rotate([-90, 0, 0]) m3(100);
        translate([38,-50,h_fan+7]) rotate([-90, 0, 0]) m3(100);
        translate([-fan_nut_x,0,-1]) m3(10);
        translate([fan_nut_x,0,-1]) m3(10);
        translate([fan_nut_x,0,2]) nut(3);
        translate([-fan_nut_x,0,2]) nut(3);
    }
    %translate([-10,7.5,h_fan]) rotate([0, -90, 180])fan_radial();
}

module vent_fan_radial(h){
    e = 4;
    y=6;
    x = 2+7.5-2;
    fan_lg = 15;
    r = fan_lg/2+e_fan;
    lg = fan_lg+2*e_fan;
    difference(){
        union(){
            translate([-fan_nut_x-e,-lg/2,-e])cube([2*(fan_nut_x+e),lg,e]);
            translate([-11,-lg/2,-h]) cube([22, lg,h]);
            hull(){
                translate([0,0,-h]) rotate([0, 90, 0]) cylinder(r=r, 22, center = true);
                translate([0,x,-h-y]) rotate([0, 90, 0])  cylinder(r=4, 22, center = true);
            }
        }
        translate([-10,-15/2,-h]) cube([20,15,h+1]);
        hull(){
            translate([0,0,-h]) rotate([0, 90, 0]) cylinder(r=15/2, 20, center = true);
            translate([0,x,-h-y]) rotate([0, 90, 0]) cylinder(r=2, 20, center = true);
        }
        translate([0,x,-h-y]) rotate([-40, 0, 0]) cube([20,10,4], center= true);
        
        translate([-fan_nut_x,0,-10]) m3(20);
        translate([fan_nut_x,0,-10]) m3(20);
    }
}
support_fan_radial();
vent_fan_radial(20);