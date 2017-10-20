include <config.scad>

LM10UU_l = 29.5;
LM10UU_r = 19.6/2;
e = 3;
tige_r = r10;
r_ecrou = 15.2/2;
r_tige_ecrou = 9/2;
h_ecrou = 6;

tige_esp = LM10UU_l*2 + e + tige_r*2;

separation = 80;
nut_emplacement = -40;
vis_ecart = 40;

$fn = 100;

module LMUU(){
	rotate([0,90,0])cylinder(LM10UU_l, r=LM10UU_h/2);
	translate([LM10UU_l/2, LM10UU_h/2 + 2, 0]) cube([4,2,100], center=true);
	translate([LM10UU_l/2, -LM10UU_h/2 - 2, 0]) cube([4,2,100], center=true);
}

module test(){
    difference(){
        translate([ 0, 0, 0]) cylinder(LM10UU_l + e, r = LM10UU_r + e);
        translate([ 0, 0, -1]) cylinder(LM10UU_l + 1, r = LM10UU_r);
        translate([ 0, 0, LM10UU_l + 0.2]) cylinder(LM10UU_l + 1, r = tige_r + 1);
    }      
}

module z(nut = true){
    difference(){
        union(){
            translate([ separation, 0, 0]) cylinder(LM10UU_l + e, r = LM10UU_r + e);
            translate([-separation, 0, 0]) cylinder(LM10UU_l + e, r = LM10UU_r + e);
            translate([-0, 0, 0]) cylinder(e+h_ecrou, r = r_ecrou+e);
            if(nut){
                translate([nut_emplacement - 6, -6, e-1]) cube([12,12, e+6]);
            }
            hull(){
                translate([-separation, 0, 0]) cylinder(e, r = LM10UU_r + e);
                translate([ separation, 0, 0]) cylinder(e, r = LM10UU_r + e);
                translate([-separation-20, 0, 0]) cylinder(e, r = 5);
                translate([ separation+20, 0, 0]) cylinder(e, r = 5);
                translate([-separation, 20, 0]) cylinder(e, r = 5);
                translate([separation, 20, 0]) cylinder(e, r = 5);
            }
        }
        for(i = [0,1]){
            mirror([i,0,0])translate([ separation, 0, -1]) cylinder(LM10UU_l + 1, r = LM10UU_r);
            mirror([i,0,0])translate([ separation, 0, LM10UU_l + 0.2]) cylinder(LM10UU_l + 1, r = tige_r + 1);
        }
        
        translate([ 0, 0, e]) cylinder(r= r_ecrou, h_ecrou+1, $fn = 6);
        translate([ 0, 0, -1]) cylinder(r= r_tige_ecrou, 10);
        
        translate([-80-20, 0, -1]) m3(e + 2);
        translate([-80+20, 0, -1]) m3(e + 2);
        translate([ 80-20, 0, -1]) m3(e + 2);
        translate([ 80+20, 0, -1]) m3(e + 2);
        translate([ -20, 0, -1]) m3(e + 2);
        translate([ +20, 0, -1]) m3(e + 2);
        translate([-separation, 20, -1]) m3(e + 2);
        translate([ separation, 20, -1]) m3(e + 2);
        
        if(nut){
            translate([nut_emplacement, 0, e+2]) rotate([0,0,-90]) support_nut();
        }
    }
}

module little_z(nut = true){
    difference(){
        union(){
            hull(){
                translate([0, 0, 0]) cylinder(e, r = LM10UU_r + e);
                translate([-20, 0, 0]) cylinder(e, r = 5);
                translate([+20, 0, 0]) cylinder(e, r = 5);
                translate([0, +20, 0]) cylinder(e, r = 5);
            }
            translate([0, 0, 0]) cylinder(LM10UU_l + e, r = LM10UU_r + e);
        }
        for(i = [0,1]){
            mirror([i,0,0])translate([ 0, 0, -1]) cylinder(LM10UU_l + 1, r = LM10UU_r);
            mirror([i,0,0])translate([ 0, 0, LM10UU_l + 0.2]) cylinder(LM10UU_l + 1, r = tige_r + 1);
        }
        
        translate([ -20, 0, -1]) m3(e + 2);
        translate([ +20, 0, -1]) m3(e + 2);
        translate([ 0, +20, -1]) m3(e + 2);
    }
}

module z_ecrou(){
    h = h_ecrou + e;
    difference(){
        union(){
            hull(){
                translate([-vis_ecart/2, 0, 0]) cylinder(h, r = 5);
                cylinder(e + 6, r = 12);
                translate([vis_ecart/2, 0, 0]) cylinder(h, r = 5);
            }
        }
        translate([-vis_ecart/2, 0, -1]) m3(h+2);
        translate([0, 0, e]) cylinder(10, r = r_ecrou, $fn=6);
        translate([0, 0, -1]) cylinder(h+2, r = r_tige_ecrou);
        translate([vis_ecart/2, 0, -1]) m3(h+2);
    }
}

module z_stop_ecrou(){
    vis_ecart = 30;
    h = 10;
    difference(){
        union(){
            hull(){
                translate([-vis_ecart/2, 0, 0]) cylinder(h, r = 5);
                translate([vis_ecart/2, 0, 0]) cylinder(h, r = 5);
                translate([-6, -6, 0])cube([12,12,10]);
            }
            
        }
        translate([-vis_ecart/2, 0, -1]) m3(h+2);
        translate([0, 0, e+2]) rotate([0,0,90]) support_nut(3, 20, 20, 20, 0.2);
        translate([vis_ecart/2, 0, -1]) m3(h+2);
    }
}

module z_stop(){
    vis_ecart = 30;
    h = 15;
    difference(){
        union(){
            hull(){
                translate([-vis_ecart/2, 0, 0]) cylinder(e, r = 5);
                translate([vis_ecart/2, 0, 0]) cylinder(e, r = 5);
            }
            translate([-10, 3.5, 0])cube([20,4,h+4]);
        }
        translate([-vis_ecart/2, 0, -1]) m3(10);
        translate([vis_ecart/2, 0, -1]) m3(10);
        
        translate([-10/2, 0, h]) rotate([-90,0,0]) cylinder(30, r= 3/2);
        translate([10/2, 0, h]) rotate([-90,0,0]) cylinder(30, r= 3/2);
    }
}

rotate([0,0,45])z(true);
//z_ecrou();
//xy(120);

//corner();
//translate([0,2*lg_xy+4,0])middle2();
