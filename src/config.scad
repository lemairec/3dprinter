r4 = 2.2;
r8 = 4.2;
r10 = 5.2;

layer_height = 0.25;

switch_d = 9.6;

nema17_r_vis = 15.5;
nema17_r_centre = 11.5;
nema17_h_centre = 2;
nema17_h = 43;
nema17_l = 40;

boite_ui_largeur = 28.5;
boite_ui_l = 46;

support_laser = 24;

r3 = 1.75;
r3_2d = 1.5;
r3_vis = 1.65;
r3_head = 3.6;
m3_r = r3;
m3_nut_d = 7;
m3_nut_d2 = 6.2;
m3_nut_h = 3;

m4_nut_d = 8;
m4_nut_d2 = 7;
m4_nut_h = 4;

608_r = 23/2;
608_h = 8;

laser_printer_l = 609;
laser_printer_lg = 456;

module support_nut(d=3, l_screw1 = 20, l_screw2 = 20, l_nut = 20, h_screw2 = -0.1){
    if(d==3){
        screw_r = r3;
        nut_r = m3_nut_d/2;
        nut_h = m3_nut_h;
        cylinder(nut_h, r = nut_r, $fn = 6, center = true);
        translate([0, 0, -l_screw1])cylinder(l_screw1 +1, r = screw_r);
        translate([0, 0, m3_nut_h/2+ h_screw2])cylinder(l_screw2, r = screw_r);
        l = m3_nut_d*cos(30);
        translate([0, -l/2, -nut_h/2]) cube([l_nut, l,nut_h]);
    } else if(d==4){
        screw_r = r4;
        nut_r = m4_nut_d/2;
        nut_h = m4_nut_h;
        cylinder(nut_h, r = nut_r, $fn = 6, center = true);
        translate([0, 0, -l_screw1])cylinder(l_screw1 +1, r = screw_r);
        translate([0, 0, m4_nut_h/2+ h_screw2])cylinder(l_screw2, r = screw_r);
        l = m4_nut_d*cos(30);
        translate([0, -l/2, -nut_h/2]) cube([l_nut, l,nut_h]);
    }
}


module nut(d=3, center = false){
    nut_r = m3_nut_d/2;
    nut_h = m3_nut_h;
    if(d==3){
        nut_r = m3_nut_d/2;
        nut_h = m3_nut_h;
    } 
    cylinder(nut_h, r = nut_r, $fn = 6, center = center);
}



module m3(h, nut = false, head = false){
    cylinder(h, m3_r, m3_r, $fn=16);
    if(nut){
        cylinder(m3_nut_h, r = m3_nut_d/2, $fn = 6);
    }
}

module m3_nut(h){
    cylinder(m3_nut_h, r = m3_nut_d/2, $fn = 6);
    translate([0, -m3_nut_d2/2, 0]) cube([h, m3_nut_d2, m3_nut_h]);
}

m4_r = 2.3;
m4_nut_d = 8.4;
m4_nut_d2 = 7.5;
m4_nut_h = 3.5;
module m4(h, nut = false, head = false){
    cylinder(h, m4_r, m4_r);
    if(nut){
        cylinder(m4_nut_h, r = m4_nut_d/2, $fn = 6);
    }
}

module m5(h, nut = false, head = false){
    cylinder(h, r = 2.7);
}

m8_nut_d = 15;
m8_nut_d2 = 13;
m8_nut_h = 6.5;
module m8(h, nut = false, head = false){
    cylinder(h, r = r8);
    if(nut){
        cylinder(m8_nut_h, r = m8_nut_d/2, $fn = 6);
    }
}

module cube_arrondi(x, y, z, r=2){
    hull(){
        translate([(x/2-r), (y/2-r), 0]) cylinder(z,r=r);
        translate([(x/2-r), -(y/2-r), 0]) cylinder(z,r=r);
        translate([-(x/2-r), (y/2-r), 0]) cylinder(z,r=r);
        translate([-(x/2-r), -(y/2-r), 0]) cylinder(z,r=r);
    }
}

module demi_glissiere(r, l, h){
    cylinder(h, r, r);
    translate([-r, 0, 0]) cube([r*2, l, h]);
}


module nema17_2d(){
    nema17_l = 43;
    nema17_h = 6;
    polygon([[0,nema17_h], [nema17_h,0]
            , [nema17_l-nema17_h,0],[nema17_l,nema17_h]
            , [nema17_l,nema17_l-nema17_h],[nema17_l-nema17_h,nema17_l]
            , [8,nema17_l],[0,nema17_l-nema17_h] ]);
}

module nema17_2d2(){
    translate([nema17_r_vis, nema17_r_vis] ) circle(r3_2d);
    translate([nema17_r_vis, -nema17_r_vis] ) circle(r3_2d);
    translate([-nema17_r_vis, nema17_r_vis] ) circle(r3_2d);
    translate([-nema17_r_vis, -nema17_r_vis] ) circle(r3_2d);
    circle(nema17_r_centre);
}


module nema17(){
    translate([-nema17_h/2, -nema17_h/2, -nema17_l/2] ) linear_extrude(nema17_l) nema17_2d();
    
    h = nema17_h/2+6;
    translate([nema17_r_vis, nema17_r_vis, 0] )rotate([0, 0, 0]) cylinder(h, r = r3);
    translate([nema17_r_vis, -nema17_r_vis, 0] )rotate([0, 0, 0]) cylinder(h, r = r3);
    translate([-nema17_r_vis, nema17_r_vis, 0] )rotate([0, 0, 0]) cylinder(h, r = r3);
    translate([-nema17_r_vis, -nema17_r_vis, 0] )rotate([0, 0, 0]) cylinder(h, r = r3);
    cylinder(h, nema17_r_centre, nema17_r_centre);
    cylinder(h+14, r = 8);
    
    translate([-8.5, 0, -nema17_l/2] ) cube([17,30, 10]);
}

module corner(l_corner, h_corner, lg_corner){
    translate([0, lg_corner, 0]) rotate([90, 0, 0]) linear_extrude(lg_corner) polygon([[0,0], [l_corner, 0], [0, h_corner]]);
}


/**
 * 2D
 **/

module m3_2d(){
    circle(r3_2d);
}


module cran_x(_l, e, cran, inv){
    difference(){
        square([_l, e]);
        if(inv){
            for(i=[-round(_l/cran):round(_l/cran)]){
                translate([_l/2 + cran/2 - 2*i*cran, -1]) square([cran, e+2]);
            }
        }else{
            for(i=[-round(_l/cran):round(_l/cran)]){
                translate([_l/2 - cran/2 - 2*i*cran, -1]) square([cran, e+2]);
            }
        }
    }
}

module cran_y(_l, e, cran, inv){
    translate([e, 0]) rotate([0, 0, 90]) cran_x(_l, e, cran, inv); 
}

module whole_2d(type_vis){
    if(type_vis == 3){
        circle(1.5);
    } else if(type_vis == 4){
        circle(2);
    } else {
        echo("whole_2d " + type_vis);
    }
}

module nuts_2d(type_vis){
    if(type_vis == 3){
        translate([-1.5, 0])square([3, 20]);
        translate([-5.5/2, 10])square([5.5, 2.5]);
    } else if(type_vis == 4){
        translate([-2, 0])square([4, 30]);
        translate([-7/2, 20])square([7, 3.5]);
    } else {
        echo("nuts_2d " + type_vis);
    }
}

module cran_x_vis(_l, e, cran, type_vis = 3, trous = [0.1, 0.5, 0.9]){
    difference(){
        square([_l, e]);
        for(i=[-round(_l/cran):round(_l/cran)]){
                translate([_l/2 - cran/2 - 2*i*cran, -1]) square([cran, e+2]);
            }
        
    }
    for(i = trous){
        j = round((i-0.5)*_l/(2*cran));
        translate([_l/2  - 2*j*cran, e/2]) whole_2d(type_vis);
    }
}

module cran_x_nuts(_l, e, cran, type_vis = 3, trous = [0.1, 0.5, 0.9]){
    difference(){
        square([_l, e]);
        for(i=[-round(_l/cran):round(_l/cran)]){
                translate([_l/2 + cran/2 - 2*i*cran, -1]) square([cran, e+2]);
        }
    }
    for(i = trous){
        j = round((i-0.5)*_l/(2*cran));
        translate([_l/2  - 2*j*cran, e/2]) nuts_2d(type_vis);
    }
}

module cran_y_vis(_l, e, cran, type_vis = 3, trous = [0.1, 0.5, 0.9]){
    translate([e, 0]) rotate([0, 0, 90]) cran_x_vis(_l, e, cran, type_vis, trous);
}

module cran_y_nuts(_l, e, cran, type_vis = 3, trous = [0.1, 0.5, 0.9]){
    translate([0, _l]) rotate([0, 0, -90]) cran_x_nuts(_l, e, cran, type_vis, trous);
}
