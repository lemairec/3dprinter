include <config.scad>

LM10UU_l = 30;
LM10UU_r = 20/2;
e = 3;
tige_r = r10;

l_xy = LM10UU_l*2 + 4;
lg_xy = 40;

tige_esp = l_xy - 2*e -2*tige_r;


module LMUU(){
	cylinder(LM10UU_l, r=LM10UU_r);
}


LMUU_h = 1;
module LMUU_OUT_in(){
    union(){
        cylinder(LM10UU_l + 2*LMUU_h , r=LM10UU_r+e);
        hull(){
            translate([LM10UU_r+2,0,LM10UU_l/2+ LMUU_h])
                rotate([90,0,0])cylinder(2*(LM10UU_r+e), r=2+e, center = true);
            translate([0,-(LM10UU_r+e),0])cube([1, 2*(LM10UU_r+e), LM10UU_l + 2*LMUU_h]);
        }
        
    }
}

module LMUU_OUT_diff(){
    translate([0,0,LM10UU_l/2+LMUU_h]) difference(){
        cylinder(LM10UU_l + 10, r=LM10UU_r, center=true);
        translate([-LM10UU_r,-6,LM10UU_l/2]) cube([2,12,10]);
        mirror([0,0,1])translate([-LM10UU_r,-6,LM10UU_l/2]) cube([2,12,10]);
    }
    translate([0,-(LM10UU_r+e-4),-1])cube([30,(LM10UU_r+e-4)*2,LM10UU_l+10]);
    l = 40;
    translate([LM10UU_r+2,l/2,LM10UU_l/2+LMUU_h])rotate([90,0,0])m3(l);
    %translate([LM10UU_r+2,l/2,LM10UU_l/2+LMUU_h])rotate([90,0,0])m3(l);
}

module LMUU_OUT(){
    difference(){
        LMUU_OUT_in(h);
        LMUU_OUT_diff(h);
        
        
        
    }

}

h_int = 17;
lg_int1 = 12;
lg_int2 = 16;
module corner(){
    l = LM10UU_l*2 + 4;
	difference(){
        union(){
            hull(){
                translate([0, 0, -l/2])cylinder(l, r= LM10UU_r+ e);
                translate([40, (LM10UU_r + e - 3), -l/2]) cylinder(l, r=3);
                translate([40, -(LM10UU_r + e - 3), -l/2]) cylinder(l, r=3);
            }
            rotate([0,0,90]) LMUU_OUT_in();
            mirror([0,0,1])rotate([0,0,90]) LMUU_OUT_in();
        }
        
        for(i=[0,1]){
            mirror([0,0,i]) rotate([0,0,90]) LMUU_OUT_diff();
            mirror([0,0,i]) translate([LM10UU_r+e,LM10UU_r+e,LM10UU_l/2+LMUU_h]) rotate([0,90,0])nut(3);
        
        }
        translate([LM10UU_r + e, -h_int/2, -l/2-1]) cube([lg_int1, h_int, l+2]);
        translate([LM10UU_r + e, -h_int/2, -lg_int2/2]) cube([40, h_int, lg_int2]);
        translate([LM10UU_r + e + 8, 50, 0]) rotate([90,0,0])m3(100);
        translate([LM10UU_r + e, 0, tige_esp/2]) rotate([0,90,0]) cylinder(50, r=tige_r);
        translate([LM10UU_r + e, 0, -tige_esp/2]) rotate([0,90,0]) cylinder(50, r=tige_r);
    }
    
}

module middle(){
	lg = 50-6;
	h=12;
	x = 6 + LM10UU_r;
	l = 2*x+tige_esp;
	difference(){
        hull(){
            translate([l/2,lg/2,0]) cylinder(h, r=3);;
            translate([-l/2,lg/2,0]) cylinder(h, r=3);;
            translate([l/2,-lg/2,0]) cylinder(h, r=3);
            translate([-l/2,-lg/2,0]) cylinder(h, r=3);
        }
		for(i=[-1,1]){
			translate([i*tige_esp/2, -100, h])rotate([-90,0,0])cylinder(1000, r=tige_r+1);
			translate([i*tige_esp/2, -LM10UU_l/2, h])rotate([0,90,90])LMUU();
		}
		translate([0,0,-1])cylinder(100,r=12);
	}
}

module xy(l, x){
    l_tige = l - 50;
    echo("longueur tige ", l_tige);
    translate([0,-l/2,0]) rotate([90, 0, 90])corner();
    mirror([0,1,0]) translate([0,-l/2,0]) rotate([90, 0, 90])corner();
    translate([0, x, 12])rotate([-180,0,0])middle();
    %translate([tige_esp/2,-l_tige/2,0]) rotate([-90,0,0])cylinder(r=5,l_tige);
    %translate([-tige_esp/2,-l_tige/2,0]) rotate([-90,0,0])cylinder(r=5,l_tige);
}

if(true){
    xy(340, -100);
} else {
    corner();
}

//corner();
//translate([0,90+2,0]) mirror([0,1,0]) corner();
//translate([0,2*lg_xy+4,0])middle();
