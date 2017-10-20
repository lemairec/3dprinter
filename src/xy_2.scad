include <config.scad>
include <other/jhead.scad>
use <fan.scad>
use <xy.scad>

LM10UU_l = 30;
LM10UU_r = 20/2;
e = 3;
tige_r = 5;

l_xy = 2*(e + 2*tige_r+LM10UU_l);
lg_xy = 40;

//tige_esp = l_xy - 2*e -2*tige_r;
tige_esp = 80;


module titan_extruder(){
    translate([0, 0, 10])rotate([0,180,0]) jhead();
    translate([-12, -12, 0])cube([27,47,47]);
    translate([+15, -12-8, 0])cube([40,62,2]);
    translate([20, -16, -10])m4(10);
    translate([20, -16+54, -10])m4(10);
    translate([20 + 30, -16, -10])m4(10);
    translate([20 + 30, -16+54, -10])m4(10);
}

module LMUU(){
	cylinder(LM10UU_l, r=LM10UU_r);
}

module LMUU_OUT(){
    difference(){
        LMUU_OUT_in(10, 10);
        LMUU_OUT_diff(10, 10);
        
        
        
    }

}



lg_xy = 40;
module corner(){
    
    h = 28;
	x = e + 2*tige_r;
    
    l = tige_esp + 2*(tige_r + e);
    button = (l - 2*LM10UU_l)/4;
    r =3;
	difference(){
        union(){
            translate([-10, -h]) hull(){
                translate([ lg_xy, r, -l/2]) cylinder(l, r=3);
                translate([0, r, -l/2]) cylinder(l, r=3);
                translate([lg_xy, h-r, -l/2]) cylinder(l, r=3);
                translate([0,h-r,  -l/2]) cylinder(l, r=3);
            }
            rotate([0,0,90]) translate([0,0,0])LMUU_OUT_in(button, button);
            mirror([0,0,1]) rotate([0,0,90]) translate([0,0,0])LMUU_OUT_in(button, button);
        }
        
        rotate([0,0,90]) translate([0,0,0])LMUU_OUT_diff(button, button);
        mirror([0,0,1]) rotate([0,0,90]) translate([0,0,0])LMUU_OUT_diff(button, button);
        

        translate([0, 0, -1]) rotate([90,0,0]) cylinder(100, r=1.6, center = true);
        x = -7 - LM10UU_r - 1;
        
        translate([0, x, -1]) cube([14,14,l+3], center = true);
        translate([0, x, -1]) cube([l+3, 14,14], center = true);
        translate([0, x, -tige_esp/2]) rotate([90,0,90]) cylinder(100, r=tige_r, center = true);
        translate([0, x, tige_esp/2]) rotate([90,0,90]) cylinder(100, r=tige_r, center = true);
    }
    echo(tige_esp)
    translate([-10, -10, LM10UU_l+2.3]) cube([20,10, 0.3]);
    
}

//corner();

module middle(){
    lg_d = 2;
	lg = 2*LM10UU_l+2*lg_d;
	h=3;
	x = 6 + LM10UU_r;
	l = tige_esp+ 15;
    pt_fan_radial = [-tige_esp/2-12,-12,-lg/2];
    pt_fan = [0,-13+27,-lg/2];
    fan_40_d = 31;
    difference(){
        union(){
            translate([-l/2,-13,-lg/2]) cube([l, h, lg]);
            translate([tige_esp/2+17-40,-13,-lg/2]) cube([40, h, lg+10]);
            translate(pt_fan_radial) cylinder(25, r=5);
            mirror([0,0,1]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate(pt_fan) cube_arrondi(40, 40, 8);
            translate([tige_esp/2, 0, 0]) rotate([0,0,90]) LMUU_OUT_in(lg_d);
            translate([tige_esp/2, 0, 0]) rotate([180,0,90]) LMUU_OUT_in(lg_d);
            translate([-tige_esp/2, 0, -lg/2]) rotate([0,0,90])LMUU_OUT_in(lg/2);
		}
        translate([tige_esp/2, 0, 0]) rotate([0,0,90]) LMUU_OUT_diff();
        translate([tige_esp/2, 0, 0]) rotate([180,0,90]) LMUU_OUT_diff();
        translate([-tige_esp/2, 0, -lg/2]) rotate([0,0,90]) LMUU_OUT_diff();
        
        for(i = [0,1]){
                mirror([0,0,i]) translate([0,-50,lg/2 - 4]) rotate([-90,0,0]) m3(100);
        }
        
        for(i=[-1,1]){
            translate(pt_fan) translate([i*fan_40_d/2, -fan_40_d/2, -1 ]) m3(14);
            translate(pt_fan) translate([i*fan_40_d/2, +fan_40_d/2, -1 ]) m3(14);
        }
        translate(pt_fan)translate([0, 0, -1]) cylinder(20, r = 18);
        
        translate(pt_fan_radial) m3(100);
        translate([0,-10,lg/2 - 4]) rotate([90,0,0]) cylinder(r = 4, 14);
        
        rotate([90,0,0]) cylinder(100, r=15);
        translate([0,-15,0]) rotate([90,0,0]) titan_extruder();
        
	}
    %translate([0,-13,0]) rotate([90,0,0]) titan_extruder();
    //%translate(pt_fan) rotate([90,0,0]) fan_40();
    
    %translate([-tige_esp/2-13, 35, -5]) mirror([1,0,0])rotate([90,0,-8]) fan_radial();
}

module middle2(){
    lg_d = 2;
	lg = 2*LM10UU_l+2*lg_d;
	h=3;
	x_extruder = 4;
    x_extruder2 = 8;
    l = tige_esp+ 15;
    pt_fan = [x_extruder,-13+27,-lg/2];
    fan_40_d = 31;
    difference(){
        union(){
            translate([-l/2,-13,-lg/2]) cube([l, h, lg]);
            translate([tige_esp/2+x_extruder2-20,-13,-lg/2]) cube([40, h, lg+10]);
            mirror([0,0,1]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate(pt_fan) cube_arrondi(40, 40, 8);
            translate([tige_esp/2, 0, 0]) rotate([0,0,90]) LMUU_OUT_in(lg_d);
            translate([tige_esp/2, 0, 0]) rotate([180,0,90]) LMUU_OUT_in(lg_d);
            translate([-tige_esp/2, 0, -lg/2]) rotate([0,0,90])LMUU_OUT_in(lg/2);
		}
        translate([tige_esp/2, 0, 0]) rotate([0,0,90]) LMUU_OUT_diff();
        translate([tige_esp/2, 0, 0]) rotate([180,0,90]) LMUU_OUT_diff();
        translate([-tige_esp/2, 0, -lg/2]) rotate([0,0,90]) LMUU_OUT_diff();
        
        for(i = [0,1]){
                mirror([0,0,i]) translate([0,-50,lg/2 - 4]) rotate([-90,0,0]) m3(100);
        }
        
        for(i=[-1,1]){
            translate(pt_fan) translate([i*fan_40_d/2, -fan_40_d/2, -1 ]) m3(14);
            translate(pt_fan) translate([i*fan_40_d/2, +fan_40_d/2, -1 ]) m3(14);
        }
        translate(pt_fan)translate([0, 0, -1]) cylinder(20, r = 18);
        
        translate([0,-10,lg/2 - 4]) rotate([90,0,0]) cylinder(r = 4, 14);
        
        translate([x_extruder2,0,0]) rotate([90,0,0]) cylinder(100, r=13);
        translate([x_extruder2,-15,0]) rotate([90,0,0]) titan_extruder();
        
        translate([-15,0,-20]) rotate([90,0,0]) m3(100);
        translate([-15,0,20]) rotate([90,0,0]) m3(100);
        translate([-15,0,0]) rotate([90,0,0]) cube([15,20,200],center=true);
        
        
	}
    %translate([x_extruder2,-13,0]) rotate([90,0,0]) titan_extruder();
    //%translate(pt_fan) rotate([90,0,0]) fan_40();
    
    translate([-tige_esp/2+28, -12, -0]) mirror([1,0,0])rotate([0,-90,180]) support_fan_radial();;
    // %translate([-tige_esp/2-25, 15, 10]) mirror([1,0,0])rotate([180,0,-60]) fan_radial();
}

module xy(l, x){
    l_tige = l+25;
    echo("longueur tige ", l_tige);
    translate([0,-l/2,0]) rotate([90, 0, 90])corner();
    mirror([0,1,0]) translate([0,-l/2,0]) rotate([90, 0, 90])corner();
    translate([0, x, -2*tige_r-1])rotate([-90,0,0])middle();
    %translate([tige_esp/2,-l_tige/2,-2*tige_r-1]) rotate([-90,0,0])cylinder(r=5,l_tige);
    %translate([-tige_esp/2,-l_tige/2,-2*tige_r-1]) rotate([-90,0,0])cylinder(r=5,l_tige);
}



fan_pt1 = [7, 45,  0];
fan_pt2 = [50, 7,  0];
e=1;
module radial_fan_out(){
    difference(){
        union(){
            hull(){
                cube([25, 2 ,19]);
                translate([16, -40,  9]) rotate([0,0,-35]) cube([6+2*e, 2 ,18], center = true);
            }
            hull(){
                cube([25, 2 ,2]);
                translate(fan_pt1)cylinder(r=4, 2);
            }
            hull(){
                translate([10, 20,  0])cylinder(r=4, 2);
                translate(fan_pt2)cylinder(r=3, 2);
            }
        }
        translate(fan_pt1) m3(10, center=true);
        translate(fan_pt2) m3(10, center=true);
        hull(){
            translate([2.5, -1, 2])cube([20, 5 ,15]);
            translate([16, -40,  7+2]) rotate([0,0,-35]) cube([6, 2 ,16], center = true);
            //translate([10+2, -48,  2]) rotate([0,0,-25])cube([6, 2 ,15]);
        } 
        translate([2.5-1, -1, 2+6])cube([2, 5 ,2]);
    }
}


if(false){
    //corner();
} else {
    xy(200);
}

//corner();
//translate([0,90+2,0]) mirror([0,1,0]) corner();
//translate([0,2*lg_xy+4,0])middle();
