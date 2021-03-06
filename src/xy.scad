include <config.scad>
include <inc/jhead.scad>
use <other/fan_head.scad>

resolution = 4; $fs=$fs/resolution; $fa=$fa/resolution;

LM10UU_l = 29.5;
LM10UU_r = 19/2;
e = 2;
LM10UU_re = LM10UU_r+e;
LM10UU_rouv = LM10UU_r-0.5;


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


LMUU_h = 1;
module LMUU_OUT_in(buttom = 0, top = 0, e_h=1){
    l = buttom + LM10UU_l + top;
     union(){
        cylinder(l , r=LM10UU_re);
        translate([0,0,buttom]) hull(){
            translate([0,LM10UU_re,LM10UU_l/2])
                rotate([0,90,0])cylinder(2*(LM10UU_re), r=2+e, center = true);
            translate([-(LM10UU_re),0,0])cube([2*(LM10UU_re), 6, LM10UU_l]);
        }
        
    }
}


module LMUU_OUT_diff(buttom = 0, top = 0, e_h = 1, top_ = true){
    l = buttom + LM10UU_l + top;
    d_h = 2.5;
    translate([0,0,buttom]) difference(){
        translate([0,0,-e_h/2]) cylinder(LM10UU_l+e_h+top, r=LM10UU_r);
        translate([-6,-LM10UU_r,-10]) cube([12,d_h,10]);
        translate([-6,-LM10UU_r,LM10UU_l]) cube([12,d_h,1+top+e_h/2]);
    }
    translate([-LM10UU_rouv,0,-1])cube([LM10UU_rouv*2,30,l+2]);
    translate([-l/2,LM10UU_r+2,LM10UU_l/2 + buttom])rotate([0,90,0])m3(l);
    %translate([-l/2,LM10UU_r+2,LM10UU_l/2 + buttom])rotate([0,90,0])m3(l);
    
    if(top_){
        translate([0,0,-1]) cylinder(buttom+0.5-0.3, r=tige_r+1);
    } else {
        translate([0,0,-1]) cylinder(buttom+1, r=tige_r+1);    
    }
    %translate([0,0,buttom]) cylinder(LM10UU_l, r=LM10UU_r);
}

module LMUU_OUT(){
    difference(){
        LMUU_OUT_in(h);
        LMUU_OUT_diff(h);
    }

}



lg_xy = 40;
module corner(){
    de = 1;
    h = de + 3*tige_r+e;
	x = de + 2*tige_r+e;
    
    l = tige_esp + 2*(tige_r + e);
    r = 3;
    
    demi_h = l/2 - LM10UU_l -2;
	difference(){
        union(){
            translate([-10, -h]) hull(){
                translate([ lg_xy, r, -l/2]) cylinder(l, r=3);
                translate([0, r, -l/2]) cylinder(l, r=3);
                translate([lg_xy, h-r, -l/2]) cylinder(l, r=3);
                translate([0,h-r,  -l/2]) cylinder(l, r=3);
            }
            for(i=[0,1]){
                mirror([0,0,i]) LMUU_OUT_in(2, demi_h);
            }
        }

        for(i=[0,1]){
            mirror([0,0,i]) translate([0,0, -l/2]) LMUU_OUT_diff(demi_h, 2, 1, i);
        }
        //translate([0,0, -l/2]) LMUU_OUT_diff(demi_h,2);

        translate([17, 0, 0]) rotate([90,0,0]) cylinder(100, r=1.6, center = true);
        translate([0, -2*tige_r-1, -tige_esp/2]) rotate([90,0,90]) cylinder(100, r=tige_r, center = true);
        translate([0, -2*tige_r-1, tige_esp/2]) rotate([90,0,90]) cylinder(100, r=tige_r, center = true);
    }
    //translate([-10, -10, LM10UU_l+2.3]) cube([20,10, 0.3]);
}


module middle_common(x_extrude){
    lg_d = 2;
	lg = 2*LM10UU_l+2*lg_d;
	h=3;
	x = 6 + LM10UU_r;
	l = tige_esp+ 15;
    pt_fan_radial = [-tige_esp/2-12,-12,-lg/2];
    pt_fan = [x_extrude,-13+27,-lg/2];
    fan_40_d = 31;
    difference(){
        union(){
            translate([-l/2,-13,-lg/2]) cube([l, h, lg]);
            translate([x_extrude+14,-13,-lg/2]) cube([40, h, lg+10]);
            mirror([0,0,1]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate([-l/2,-13,-lg/2]) cube([l, 22, 8]);
            mirror([0,0,0]) translate(pt_fan) cube_arrondi(40, 40, 8);
            translate([tige_esp/2, 0, 0]) LMUU_OUT_in(0.5,lg_d-0.5);
            translate([tige_esp/2, 0, -lg/2]) LMUU_OUT_in(lg_d-0.5, 0.5);
            translate([-tige_esp/2, 0, -lg/2]) LMUU_OUT_in(lg/2, lg_d);
		}
        for(i=[0,1]){
            mirror([0,0,i])translate([tige_esp/2, 0, 0]) LMUU_OUT_diff(0.5,2,2);
        } 
        translate([-tige_esp/2, 0, -lg/2]) LMUU_OUT_diff(lg/2, lg_d, 1, false);
        
        
        translate([0,-10,lg/2 - 4]) rotate([90,0,0]) cylinder(r = 4, 14);
        for(i = [0,1]){
            mirror([0,0,i]) translate([0,-50,lg/2 - 4]) rotate([-90,0,0]) m3(100);
        }
        
        for(i=[-1,1]){
            translate(pt_fan) translate([i*fan_40_d/2, -fan_40_d/2, -1 ]) m3(14);
            translate(pt_fan) translate([i*fan_40_d/2, +fan_40_d/2, -1 ]) m3(14);
        }
        translate(pt_fan)translate([0, 0, -1]) cylinder(20, r = 18);
         
        translate([x_extrude, 0, 0]) rotate([90,0,0]) cylinder(100, r=14);
        translate([x_extrude,-15,0]) rotate([90,0,0]) titan_extruder();        
	}
}

module middle(fan =true){
    lg_d = 2;
	lg = 2*LM10UU_l+2*lg_d;
	h=3;
	x = 6 + LM10UU_r;
	l = tige_esp+ 15;
    pt_fan_radial = [-tige_esp/2-11,-12,-lg/2];
    pt_fan = [0,-13+27,-lg/2];
    fan_40_d = 31;
    
    difference(){
        union(){
            middle_common(0);
            
            hull(){
                translate(pt_fan_radial) cylinder(25, r=5);
                translate(pt_fan_radial) translate([4,4]) cylinder(25, r=4);
            }
        }
        for(i=[0]){
            mirror([i,0,0]) translate(pt_fan_radial) m3(100);
            translate(pt_fan_radial) m3(100);
        }
	}
    %translate([0,-13,0]) rotate([90,0,0]) titan_extruder();
    //%translate(pt_fan) rotate([90,0,0]) fan_40();
    
    if(fan){
        angle = -20;
        x = 22;
        %translate([-tige_esp/2-x+1, 35, +9]) rotate([90,180,-angle]) fan_radial();
        translate([-tige_esp/2-x, 37, +11]) rotate([180,0,-90-angle])radial_fan_out();
    }
}

h_fan = 44;
module middle2(fan = true){
    lg_d = 2;
	lg = 2*LM10UU_l+2*lg_d;
	h=3;
	l = tige_esp+ 15;
    x_extrude = 7;
    x_fan = -17.5;
    
    pt_fan = [x_extrude,-13+27,-lg/2];
    fan_40_d = 31;
    
            
    difference(){
        middle_common(x_extrude); 
        translate([x_fan-7.5,-50,-10]) cube([15,100,20]);
        
        translate([x_fan, -0, -17]) rotate([90,0,0]) m3(100);
        translate([x_fan, -0, 17]) rotate([90,0,0]) m3(100);
        
	}
    %translate([x_extrude,-13,0]) rotate([90,0,0]) titan_extruder();
    //%translate(pt_fan) rotate([90,0,0]) fan_40();
    
    if(fan){
        translate([x_fan, -13, -0]) mirror([1,0,0])rotate([90,-90,0]) support_fan_radial();;
        translate([x_fan, -10, -0]) mirror([1,0,0])rotate([90,-90,0]) vent_fan_radial(44);
    }
    // %translate([-tige_esp/2-25, 15, 10]) mirror([1,0,0])rotate([180,0,-60]) fan_radial();
}

module xy(l, x = 0){
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
fan_pt3 = [20, -46,  0];
angle = -50;

r1 = 3;
module radial_fan_out(){
    difference(){
        union(){
            hull(){
                cube([25, e ,19]);
                translate(fan_pt3) rotate([0,0,angle]) cylinder(r=r1+e, 19);
            }
            hull(){
                cube([25, e ,e]);
                translate(fan_pt1)cylinder(r=4, e);
            }
            hull(){
                translate([10, 20,  0])cylinder(r=4, 2);
                translate(fan_pt2)cylinder(r=3, 2);
            }
        }
        translate(fan_pt1) m3(10, center=true);
        translate(fan_pt2) m3(10, center=true);
        hull(){
            translate([2.5, -1, 2])cube([20, 5 ,19-2*e]);
            translate(fan_pt3) translate([0,0,e])cylinder(r=r1, 19-2*e);
        } 
        translate(fan_pt3) rotate([0,0,-90+angle]) translate([0,-r1,e])cube([2*r1,2*r1+1,19-2*e]);
        translate([2.5-1, -1, 2+6])cube([2, 5 ,2]);
    }
}


i = 0;
if(i == 0){
    xy(200);
} else if(i == 1){
    corner();
} else if(i == 2){
    middle(false);
    //middle();
} else if(i == 3){
    radial_fan_out();
    
    //support_fan_radial();;
    //vent_fan_radial(44);
} else if(i == 4){
    rotate([-180,0,0])vent_fan_radial(44);
}

//corner();
//translate([0,90+2,0]) mirror([0,1,0]) corner();
//translate([0,2*lg_xy+4,0])middle();
