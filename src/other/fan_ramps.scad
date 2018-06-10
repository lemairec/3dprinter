include <../inc/fan.scad>
include <../inc/mega_ramps.scad>

e = 2;
l= 40;
h = 50;

r = 5;
l2= 50;

$fn = 100;
module fan_ramp1(){
    l2 = l + 20;
    e_cube = 6;
    difference(){
        union(){
            hull(){
                translate([l2/2, 0, 0]) cylinder(e, r = 5);
                translate([-l2/2, 0, 0]) cylinder(e, r = 5);
            }
            translate([-l/2, -e_cube/2, 0])cube([l, e_cube, h]);
            translate([-l/2, 0, h])rotate([0,90,0]) cylinder(r=r, l);
        }
        
        translate([-l/2-1, 0, h])rotate([0,90,0]) m3(l+5);
        translate([-l/4, 0, h])rotate([0,90,0])cylinder(r=r+0.2, l/2);
        translate([l2/2 ,0,0]) m3(10);
        translate([-l2/2,0,0]) m3(10);
    }
    
}

fan_m3 = fan_40_d;
fan_r = fan_40_center;

//fan_m3 = 58;
//fan_r = 58/2;



fan_l = fan_m3+10;
fan_y = 40-fan_r/2;
fan_x= 15;

module fan_ramp2(){
    l_fan2 = l/2-0.4;
    difference(){
        union(){
            translate([-l_fan2/2, 0, r])rotate([0,90,0])cylinder(r=r, l_fan2);
            translate([-l_fan2/2, 0, 0])cube([l_fan2, fan_y+1,e]);
            
            translate([fan_x, fan_r/2 + fan_y, 0]) cube_arrondi(fan_l, fan_l,e);
            hull(){
                
            }
        }
        for(i = [-1,1]){
            for(j = [-1,1]){
                translate([fan_x+j*fan_m3/2, fan_r/2 + i*fan_m3/2 + fan_y, -1]) m3(10);
            }
        }
        translate([-l/4, 0, r])rotate([0,90,0])m3(l);
        translate([fan_x, fan_r/2 + fan_y, 0]) cylinder(r=fan_r, 10, center = true);
    }
    %translate([fan_x, fan_r/2 + fan_y, -12])rotate([90,0,0])fan_40();
}

module fan_ramp1_bis(){
    //mega();
    e_cube = 6;
    l_cube = l2+10;
    difference(){
        union(){
            translate([-l_cube/2, 0, 0]) cube([l_cube, 2, 10]);
            translate([-l/2, 0, 0]) cube([l, h, e_cube]);
            translate([-l/2, h, r])rotate([0,90,0]) cylinder(r=r, l);
            
            
        }
        
        translate([-l/2-1, h, r])rotate([0,90,0]) m3(l+5);
        translate([-l/4, h, r])rotate([0,90,0]) cylinder(r=r+0.2, l/2);
        
        translate([l2/2 ,-1 ,r]) rotate([-90,0,0]) m3(10);
        translate([-l2/2 ,-1 ,r]) rotate([-90,0,0]) m3(10);
        
    }
    
}

if(false){
    translate([0,-r,0]) rotate([90,0,180]) fan_ramp1_bis();
    translate([0,0,h+r]) rotate([0,180,0])fan_ramp2();
} else {
    translate([-l2,0,0])fan_ramp1_bis();
    fan_ramp2();
}
