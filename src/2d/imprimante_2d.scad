$fn=100;

include <../config.scad>
use <../inc/alim_atx.scad>
use <../z.scad>
use <../corner_roulement.scad>
use <imprimante_2d_top.scad>



e = 6; //2.74
cran = 25;

top_int = 240;
top_int_r = 20;

l = 440;
lg = 420;

h1 = 110;
h2 = 445-e;
h = 500;

poignee = true;

r_glis = 5.0;
h_glis = 32;

vis_fixation = 4;

z_axe_dist = 310;
    

r_tige = 4.9;
tige_fixation = 30;
tige_fixation_z = 40;
tige_fixation_r = 1.5;

nema_dx = 43/2;
roul_dx = 0;

fixation_x = 45;

x = -100;
y = -108;

int_front = 70;




use <../xy.scad>
xy_dh = 39;
xy_dx = nema_dx;

/*use <../xy_in.scad>
xy_dh = 19;
xy_dx = 18;
nema_dx = 36;
motor2 = false;*/

roul_x = lg/2-nema_dx -roul_dx;

module screen_2d(){
    m3_2d();
    translate([145    , 0])      m3_2d();
    translate([0      , 50])     m3_2d();
    translate([145    , 50])     m3_2d();
    
    hull(){
        translate([-30     , 25])      circle(30/2);
        translate([120     , 25])      circle(30/2);
    }
}

module tige_2d(vis = false){
    circle(r_glis);
    if(vis){
        translate([0, -tige_fixation/2]) circle(tige_fixation_r);
        translate([0, tige_fixation/2]) circle(tige_fixation_r);
    }
}

module bouton_2d(pin = true){
    if(pin){
        translate([-30,0])square([12,20], center = true);
        translate([-10,0])circle(r=4);
        translate([10,0])circle(r=4);
        translate([30,0])circle(r=4);
    } else {
        square([17,21], center = true);
    }
}

module passe_fil_2d(){
    hull(){
        translate([-5,0])circle(r=6);
        translate([5,0])circle(r=6);
    }
}

module alim_2d_l(){
    for(i = [0,1]){
        hull(){;
            mirror([i,0,0])translate([-alim_lg/2-2, alim_l/2-2, 0]) circle(3);
            mirror([i,0,0])translate([-alim_lg/2-2, alim_l/2+2, 0]) circle(3);
        } 
    }
    translate([-55 + 10, 15]) square([110, 110]);
}

/**
 * top bottom
 **/

module top_bottom(vis){
    difference(){
        square([l, lg], center = true);
        
        //Z
        translate([ z_axe_dist/2, 80]) tige_2d(true);
        translate([ -z_axe_dist/2, 80]) tige_2d(true);
        translate([ z_axe_dist/2, -80]) tige_2d(true);
        translate([ -z_axe_dist/2, -80]) tige_2d(true);
        
        for(i = [0,1]){
            mirror([0,i,0]) translate([-l/2, -lg/2 -1])
                cran_x_nuts(l, e + 1, cran, vis_fixation, [0.25, 0.75]);
            mirror([i,0,0]) translate([-l/2 -1, -lg/2])
                cran_y_nuts(lg, e + 1, cran, vis_fixation, [0.25, 0.75]);
        }
        for(i = [-1,1]){
            for(j = [-1,1]){
                translate([i*(l/2-e-48), j*(lg/2 - e - 35)]) rotate([0,0,90]) passe_fil_2d();
            }
        }
    }
}

module top(){
    difference(){
        rotate ([0,0,180]) top_bottom(false);
         
        //Z     
        translate([ -z_axe_dist/2, 0]) tige_2d(true);
        translate([ z_axe_dist/2, 0]) tige_2d(true);
        
        translate([ -z_axe_dist/2, -40-10 ]) circle(1.5);
        translate([ -z_axe_dist/2, -40+10]) circle(1.5);
        
        hull(){
            translate([top_int/2, -lg])circle(top_int_r);
            translate([-top_int/2, -lg])circle(top_int_r);
            translate([top_int/2, top_int/2])circle(top_int_r);
            translate([-top_int/2, top_int/2])circle(top_int_r);
        }
        for(i = [0,1]){
            mirror([i,0,0]) translate([l/2 - nema_dx - e, -(lg/2 - 43/2 - e), 0])nema17_2d2();
            mirror([i,0,0]) translate([l/2- nema_dx -e - 5, lg/2 - e - 13]) hull(){
                circle(5);
            }
        }         
    }
}

module bottom(){
    difference(){
        rotate ([0,0,180]) top_bottom(true);
        
        //Z
        translate([ -z_axe_dist/2, 0]) nema17_2d2();
        translate([ z_axe_dist/2, 0]) nema17_2d2();
        
        //translate([0, lg/2-e])rotate([0,0,180])alim_2d_l();
        
        translate([ 50,  0]) circle(5);
        translate([ 0,  -lg/2+80]) fixation_mega_2d();
        
        for(r=[0,90,180,270]){
            rotate([0,0,r])translate([ 70,  0]) fixation_2d();
        }
        
        translate([ -l/4-20,  -lg/2+80]) rotate([0,0,90])fixation_2d();
        translate([ l/4+20,  -lg/2+80]) rotate([0,0,90])fixation_2d();
        translate([ -l/4-20,  lg/2-80]) rotate([0,0,90])fixation_2d();
        //translate([ l/4+20,  lg/2-80]) rotate([0,0,90])fixation_2d();
        
    }
}

/**
 * Front Back
 **/

module front_back(){
    difference(){
        translate([-l/2, 0])square([l, h]);
        hull(){
            translate([-l/4, 0])circle(20);
            translate([l/4,0])circle(20);
        }
        
        
        
        translate([-l/2-1, 0]) cran_y(h, e + 1, cran, true);
        translate([l/2-e, 0]) cran_y(h, e + 1, cran, true);
        
        translate([-l/2, h1]) cran_x_vis(l, e, cran, vis_fixation, [0.25, 0.75]);
        translate([-l/2, h2]) cran_x_vis(l, e, cran, vis_fixation, [0.25, 0.75]);
        
        translate([-l/2+xy_dx + e, h2 + xy_dh + e]) rotate([0,0,90])tige_2d(true);
        translate([l/2 - xy_dx - e, h2 + xy_dh + e]) rotate([0,0,90])tige_2d(true);
        
        for(i=[-1,1]){
            translate([i*(l/2 - e - fixation_x), h1+(h2-h1)/4])  fixation_2d();
            translate([i*(l/2 - e - fixation_x), h1+(h2-h1)/2])  fixation_2d();
            translate([i*(l/2 - e - fixation_x), h1+(h2-h1)*3/4])fixation_2d();
        }
    }
}


module front(){
    
    difference(){
        front_back();
        
        hull(){
             translate([-top_int/2, h1+20+e+10])circle(top_int_r);
            translate([+top_int/2, h1+20+e+10])circle(top_int_r);
            translate([-top_int/2, 2*h])circle(top_int_r);
            translate([+top_int/2, 2*h])circle(top_int_r);
        }
        
        //screen
        translate([- 70, h1/2-20]) screen_2d();
        translate([140, h1/2]) bouton_2d();
        
    }
}


module back(){
    difference(){
        front_back();
        
        hull(){
            translate([-l/4,h])circle(20);
            translate([l/4,h])circle(20);
        }
        
        for(i = [0,1]){
            mirror([i,0,0]) translate([roul_x - 16.5, h2+e+11.5]) circle(1.5);
            mirror([i,0,0]) translate([roul_x + 16.5, h2+e+11.5]) circle(1.5);
        }
    }
}

/**
 * Left Right
 **/

module left_right(){
    difference(){
        translate([-lg/2 - 10,0]) square([lg + 20, h]);
        hull(){
            translate([-lg/4,0])circle(20);
            translate([lg/4,0])circle(20);
        }
        
        hull(){
            translate([-lg/4, h])circle(20);
            translate([lg/4, h])circle(20);
        }
        
        if(poignee){
            hull(){
                translate([-lg/4,h2 - 30])circle(10);
                translate([lg/4,h2 - 30])circle(10);
            }
        }
        
        for(i=[0,1]){
            mirror([i,0,0]) translate([-lg/2,0]) cran_y(h, e, cran, false);
        }
        
        translate([-lg/2,h1]) cran_x_vis(lg, e, cran, vis_fixation, [0.25, 0.75]);
        translate([-lg/2,h2]) cran_x_vis(lg, e, cran, vis_fixation, [0.25, 0.75]);
    }
}

module left(){
    left_right();
}

module right(){
    difference(){
        left_right();
    
        translate([lg/2-100,h1-86]) alim_atx_2d();
    }
}

/**
 * Plateau
 **/

module plateau_enplacement_trou(){
    hull(){
        translate([0, 20])circle(15);
        translate([0, -20])circle(15);
    }
}

module plateau_trou(r, l = 50){
    hull(){
        circle(r);
        translate([l,0])circle(r);
        
    }
    translate([0, tige_fixation_z/2])circle(1.5);
    translate([0, -tige_fixation_z/2])circle(1.5);
}

module plateau(){
    difference(){
        hull(){
            r = 30;
            translate([ z_axe_dist/2, -80, h1]) plateau_enplacement_trou();
            translate([ -z_axe_dist/2, -80, h1]) plateau_enplacement_trou();
            translate([ z_axe_dist/2, 80, h1]) plateau_enplacement_trou();
            translate([ -z_axe_dist/2, 80, h1]) plateau_enplacement_trou();
            
    
        }
        translate([0, +z_axe_dist/2]) rotate([0,0,90]) plateau_trou(5);
            
        for(i = [0,1]){
            mirror([i,0,0])translate([z_axe_dist/2, 0]) plateau_trou(5);
            mirror([i,0,0])translate([ z_axe_dist/2, -80]) plateau_trou(6);
            mirror([i,0,0])translate([ z_axe_dist/2, 80]) plateau_trou(6);
            mirror([i,0,0]) translate([  z_axe_dist/2, -40]) circle(1.5);
            mirror([i,0,0]) translate([ z_axe_dist/2-20, -80]) circle(1.5);
            mirror([i,0,0]) translate([ z_axe_dist/2-20, 80]) circle(1.5);
            mirror([i,0,0]) translate([ 104,  104]) circle(1.5);
            mirror([i,0,0]) translate([ 104, -104]) circle(1.5);
        }
        translate([ 50,  0]) circle(5);
    }
}

/*
 * porte
 */

module porte(){
    hull(){
        translate([-lg/2+int_front - 5, h1+20+e+10 - 5])circle(20);
        translate([lg/2-int_front + 5, h1+20+e+10 - 5])circle(20);
        translate([-lg/2+int_front - 5, h2-(20+10) + 5])circle(20);
        translate([lg/2-int_front + 5, h2-(20+10) + 5])circle(20);
    }
}

module imprimante_3d_etape1(e2 = e){
    translate([0, 0, h2])linear_extrude(e2) top();
    translate([0, 0, h1])linear_extrude(e2) bottom();
    translate([0,-lg/2+e    ,0])rotate([90,0,0])linear_extrude(e2) front(); 
    translate([0, lg/2      ,0])rotate([90,0,0])linear_extrude(e2) back();
}   

module imprimante_3d_etape2(e2 = e){
    translate([-l/2     ,0 ,0]) rotate([90,0,90])linear_extrude(e2) left(); 
    translate([+l/2-e   ,0 ,0])rotate([90,0,90])linear_extrude(e2) right();   
}

module imprimante_3d_etape3(){
    for(i = [0,1]){
        mirror([i,0,0]) translate([-roul_x ,lg/2 - e ,h2+e+11.5])
            rotate([0,90,-90]) corner_roulement();
        mirror([i,0,0]) translate([l/2-nema_dx -e ,-(lg/2-e-45/2) ,h2 - 20])
            rotate([0,0,90]) nema17();
        mirror([i,0,0]) translate([z_axe_dist/2, 0 ,h1 - 20])
            rotate([0,0,90]) nema17();
    }  
}



module full_imprimante_3d(e2 = e, etape = 0){
    etape = 5;
    color_1 = (etape == 1) ? [0,0,1,1] : [0,0,1,0.4];
    color_2 = (etape == 2) ? [0,0,1,1] : [0,0,1,0.4];
    color_3 = "gold";
     color_4 = "gold";

    
    echo(l_xy);
    l_xy = l-xy_dx*2 - e*2;
    
    
    l_tige_y = l + 10;
    l_tige_z = h2-h1 + e;
    echo("longeur y : ", l_tige_y);
    echo("longeur z : ", l_tige_z);
    if(etape>=1){
        if(etape==1){
            color(color_1) imprimante_3d_etape1(e2);
        } else {
            % imprimante_3d_etape1(e2);
        }
    }
    if(etape>=2){
        if(etape==2){
            color(color_2) imprimante_3d_etape2(e2);
        } else {
            % imprimante_3d_etape2(e2);
        }
    }
    
    if(etape>=3){
        color(color_3) imprimante_3d_etape3(e2);
        translate([l/2-e,lg/2-100, h1]) rotate([0,180,90])alim_atx_3d();  
        
    }
    
        
    if(etape >= 4){
        h = h1 + 55;
        
        for(i = [0,1]){
            mirror([i,0,0])translate([-z_axe_dist/2, 0, h]) rotate([-180,0,-90]) z();
            %mirror([i,0,0]) translate([-z_axe_dist/2, 0, h1]) cylinder(r=r_tige, l_tige_z);
            %mirror([i,0,0]) translate([ z_axe_dist/2, -80, h1]) cylinder(r=r_tige, l_tige_z);
            %mirror([i,0,0]) translate([ z_axe_dist/2, 80, h1]) cylinder(r=r_tige, l_tige_z);
        }
        
        translate([0, 0, h]) plateau();
        translate([0, 0, h + 20]) color("red") cube([220,220,2], center = true);
        
        
        
        
    }
    if(etape >= 5){
        
        translate([0 ,y ,h2 + xy_dh + 5]) rotate([0,0,90]) xy(l_xy, -x);
        %translate([-l_xy/2, 0,h2 + xy_dh + e]) rotate([-90,0,0])cylinder(r=r_tige, l_tige_y,center=true);
        %translate([l_xy/2, 0,h2 + xy_dh + e]) rotate([-90,0,0])cylinder(r=r_tige, l_tige_y, center=true);
        
        
        y_porte = -lg/2+int_front - 5 -20;
        angle = 40;
        //%translate([y_porte,-lg/2    ,0])rotate([90,0,-angle]) translate([-y_porte, 0])linear_extrude(e2) porte();
    }
    
    
    
    
    
}

module test(){
    difference(){
        square([100,100]);
        translate([0,10])cran_x_vis(100,e, cran, 3);
        translate([0,100-10])cran_x_vis(100,e, cran, 4);
        translate([50,50]) circle(r_tige);
    }
    
    translate([120,0])difference(){
        square([100,100]);
        translate([0,-1])cran_x_nuts(100,e+1, cran, 3);
        translate([0,101])mirror([0,1,0])cran_x_nuts(100,e+1, cran, 4);
    }
}


if(true){
    translate([0,0,-h2/2]) full_imprimante_3d(e, 3);
    //translate([0,0,-h2/2 + h]) rotate([0,0,180])imprimante_3d_top(e);
    
} else {
    e1 = 10;
    %translate([-laser_printer_lg/2, 0])  square([laser_printer_lg, laser_printer_l]);
    front();
    translate([l + e1, 0]) right();
    translate([0, h+e1])back();
    translate([l + e1, h+e1]) left();
    translate([0, 2*(h+e1) + lg/2])top();
    translate([l + e1, 2*(h+e1) + lg/2]) bottom();
    translate([0, 300]) rotate([0,0,90]) plateau();
    
    //translate([lg, -200])test();
}
