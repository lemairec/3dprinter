include <../config.scad>

alim_atx_l = 150;
alim_atx_lg = 140;
alim_atx_h = 86;

module alim_atx_trou(r = 1.5){
    translate([-alim_atx_l/2+6      , alim_atx_h-6]) circle(r, $fn=16);
    translate([-alim_atx_l/2+6+138  , alim_atx_h-6]) circle(r, $fn=16);
    translate([-alim_atx_l/2+6      , alim_atx_h-64-6]) circle(r, $fn=16);
    translate([-alim_atx_l/2+6+115  , alim_atx_h-80]) circle(r, $fn=16);
}

module alim_atx_2d(){
    alim_x_vis = 138;
    translate([-60, 5, 0]) square([120, 55]);
    translate([-alim_x_vis/2-5, 25, 0]) square([80, 35]);
    translate([alim_x_vis/2-5-90, 5, 0]) square([90, 70]);
    translate([0, 86, 0]) rotate([0,0,180]) alim_atx_trou();
}

module alim_atx_3d(){
    difference(){
        translate([-alim_atx_l/2, 0, 0])cube([alim_atx_l, alim_atx_h]);
        alim_atx_trou();
    }
}

module alim_atx_3d(){
    union(){
        translate([-alim_atx_l/2, 0, 0])cube([alim_atx_l, alim_atx_lg, alim_atx_h]);
        rotate([90,0,0])  linear_extrude(10){
            alim_atx_trou();
        }
        translate([-(alim_atx_l-alim_atx_lg)/2, alim_atx_lg/2, alim_atx_h]) cylinder(3, r = 120/2);
    }
}


h = 10;
e1 = 10;
e = 3;

l = 140;
lg = 151;

module alim_atx_support(){
    difference(){
        union(){
            hull(){
                translate([-lg/2-e1, l-8+e, 0])cylinder(e, r=8);
                translate([+lg/2+e1, l-8+e, 0])cylinder(e, r=8);
            }
            translate([-lg/2-e, l,0]) cube([lg+2*e, e, h]);
            for(i = [0,1]){
                mirror([i,0,0])translate([lg/2, 0,0]) cube([ e, l+e, h]);
                mirror([i,0,0])translate([-lg/2- e, 0,0]) cube([ h, l+e, e]);
                
                mirror([i,0,0]) translate([lg/2, 0, 0]) hull(){
                    cube([ e, e, h]);
                    translate([h, 0, h/2]) rotate([-90,0,0])cylinder(e, r=h/2);
                }
            }
            
        }
        translate([-lg/2-e1, l-8+e, -1]) cylinder(e+2, r=4);
        translate([+lg/2+e1, l-8+e, -1]) cylinder(e+2, r=4);
        for(i = [0,1]){
            mirror([i,0,0]) translate([lg/2 + h, -1, h/2]) rotate([-90,0,0])cylinder(e+2, r=2);
        }
    }
    %translate([0, 0, alim_atx_h+e]) rotate([0,180,0])alim_atx_3d();
}

module alim_atx_support2(){
    difference(){
        union(){
            hull(){
                translate([-lg/2-e1, l-8+e, 0])cylinder(e, r=8);
                translate([+lg/2-2, l-16+e, 0])cube([2,16,e]);
            }
            translate([-lg/2-e, l,0]) cube([lg+e, e, h]);
            
            translate([-lg/2-e, 0,0]) cube([ e, l+e, h]);
            translate([-lg/2- e, 0,0]) cube([ h, l+e, e]);
                
            translate([-lg/2, 0, 0]) hull(){
                translate([-e, 0, 0])cube([ e, e, h]);
                translate([-h, 0, h/2]) rotate([-90,0,0])cylinder(e, r=h/2);
            }
            
            translate([lg/2-e, l, 0]) rotate([0,0,-90]) hull(){
                translate([-e, 0, 0])cube([ e, e, h]);
                translate([-h, 0, h/2]) rotate([-90,0,0])cylinder(e, r=h/2);
            }
            
        }
        translate([-lg/2-e1, l-8+e, -1]) cylinder(e+2, r=4);
        translate([+lg/2+e1, l-8+e, -1]) cylinder(e+2, r=4);
        
        translate([-lg/2 - h, -1, h/2]) rotate([-90,0,0])cylinder(e+2, r=2);
        translate([lg/2+50, l+h , h/2]) rotate([0,-90,0])cylinder(100, r=2);
    }
    %translate([0, 0, alim_atx_h+e]) rotate([0,180,0])alim_atx_3d();
}

//alim_atx_support();

alim_atx_support2();
