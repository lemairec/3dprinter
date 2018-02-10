include <fan.scad>

e = 3;
l= 40;
h = 50;

r = 5;

$fn = 100;
module fan_ramp1(){
    l2 = l + 10;
    e_cube = 4.5;
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

if(true){
    fan_ramp1();
    translate([0,0,h+r]) rotate([0,180,0])fan_ramp2();
} else {
    //translate([0,-20,0])fan_ramp1();
    fan_ramp2();
}
