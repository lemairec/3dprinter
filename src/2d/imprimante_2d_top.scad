include <../config.scad>

l = 440;
lg = 420;


h = 400;
h2 = h-10;

e = 6;
cran = 20;
vis_fixation = 4;

angle = 25;
h_front = h/cos(angle);
dh_front = e*sin(angle);

l_top = lg-h*tan(angle);

r_disque = 100;
r_disque2 = 130;

h_bobine = h2-r_disque2;
x_bobine = -lg/2+r_disque2;
r_tige = 5.1;

/**
 * top bottom
 **/

module top_bottom(){
    difference(){
        square([l, l_top], center = true);
        
        translate([-l/2, -l_top/2 -1]) cran_x_nuts(l, e + 1, cran, vis_fixation, [0.25, 0.75]);
            
        for(i = [0,1]){
            mirror([i,0,0]) translate([-l/2 -1, -l_top/2])
                cran_y_nuts(l_top, e + 1, cran, vis_fixation, [0.25, 0.75]);
        }
    }
}

module top(){
    difference(){
        top_bottom();
    }
}

/**
 * Front Back
 **/

module back(){
    difference(){
        union(){
            translate([-l/2, 0])square([l, h]);
            hull(){
                translate([-l/4,0])circle(20);
                translate([l/4,0])circle(20);
            }
        }
        
        
        for(i = [0,1]){
            mirror([i,0,0]) translate([-l/2-1, 0]) cran_y_nuts(h, e + 1, cran, vis_fixation, [0.25, 0.75]);
        }
        
        translate([-l/2, h2-e]) cran_x_vis(l, e, cran, vis_fixation, [0.25, 0.75]);
    }
}



top_int = 240;
top_int_r = 20;

        
module front(){
    difference(){
        translate([-l/2, dh_front])square([l, h_front]);
        
        
        
        for(i = [0,1]){
            mirror([i,0,0]) translate([-l/2-1, -10]) cran_y_nuts(h_front+20, e + 1, cran, vis_fixation, [0.25, 0.75]);
        }
        
        hull(){
            translate([-top_int/2, h_front-top_int/2])circle(top_int_r);
            translate([+top_int/2, h_front-top_int/2])circle(top_int_r);
            translate([-top_int/2, -top_int/2])circle(top_int_r);
            translate([+top_int/2, -top_int/2])circle(top_int_r);
        }
    }
}

/**
 * Left Right
 **/

module left_right(){
    difference(){
        union(){
            translate([-lg/2 - 10,0]) square([lg + 20, h]);
            hull(){
                translate([-lg/4,0])circle(20);
                translate([lg/4,0])circle(20);
            }
        }
        
        translate([-lg/2,h2]) rotate([0,0, -90]) cran_y_vis(l_top, e, cran, vis_fixation, [0.25, 0.75]);
        translate([-lg/2,0]) cran_y_vis(h, e, cran, vis_fixation, [0.25, 0.75]);
        translate([lg/2,0])  rotate([0,0, angle]) translate([-e,0])cran_y_vis(h_front, e, cran, vis_fixation, [0.25, 0.75]);
        translate([lg/2 + 15,0])  rotate([0,0, angle]) square([lg + 20, h_front]);
        
        translate([x_bobine ,h_bobine]) circle(r_tige);
        /*translate([x_bobine ,h_bobine-30]) circle(r_tige);
        translate([x_bobine ,h_bobine+30]) circle(r_tige);
        translate([x_bobine ,h_bobine-60]) circle(r_tige);
        translate([x_bobine-30 ,h_bobine]) circle(r_tige);
        translate([x_bobine-30 ,h_bobine-30]) circle(r_tige);
        translate([x_bobine-30 ,h_bobine+30]) circle(r_tige);
        translate([x_bobine-30 ,h_bobine-60]) circle(r_tige);
        translate([x_bobine+30 ,h_bobine]) circle(r_tige);
        translate([x_bobine+30 ,h_bobine-30]) circle(r_tige);
        translate([x_bobine+30 ,h_bobine+30]) circle(r_tige);
        translate([x_bobine+30 ,h_bobine-60]) circle(r_tige);*/
        
    }
}


module left(){
    left_right();
}

module right(){
    difference(){
        left_right();
        hull(){
        translate([lg/2-60,0]) circle(7);
            translate([lg/2-60,30]) circle(7);
        }
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

module imprimante_3d_top(e2 = e){
    translate([0,-lg/2+e    ,0])rotate([90,0,0])linear_extrude(e2) back(); 
    translate([-l/2     ,0 ,0]) rotate([90,0,90])linear_extrude(e2) right(); 
    translate([+l/2-e   ,0 ,0])rotate([90,0,90])linear_extrude(e2) left();
    translate([0, lg/2,0])rotate([90+angle,0,0]) linear_extrude(e2) front();   
    translate([0, -(-l_top+lg)/2, h2-e])linear_extrude(e2) top();
    
    translate([0,x_bobine ,h_bobine]) color("red") rotate([0,90,0]) cylinder(r = r_disque, 80, center = true);
    translate([0,x_bobine ,h_bobine]) color("red") rotate([0,90,0]) cylinder(r = r_tige, l+10, center = true);
}

module plaque(l, lg){
    %square([l, lg]);
    echo("plaque ", l, lg);
    
}

if(false){
    imprimante_3d_top(e);
} else {
    e= 10;
    translate([-l/2, -20])plaque(456, 609);
    left();
    translate([0,h+22])right();
    //back(); 
    translate([456+10,0]){
        translate([-l/2, -20])plaque(456, 609);
        back();
    }
    
    translate([-(456+10),0]){
        translate([-l/2, 0]) plaque(456, 609);
        translate([0, 610-h_front-20]) front();
        translate([0,l/2]) rotate([0,0,90])top();
    }
}