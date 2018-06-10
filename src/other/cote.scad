$fn = 100;

r_vis = 1.6;
r1 = 5;
r2 = 8;
e_porte = 3.5;
e = 2;


module cote(){
    difference(){
        union(){
            cylinder(r= r2,e);
            cylinder(r= r1,e+e_porte);
        }
        translate([0, 0,-1])cylinder(r= r_vis,e+e_porte+2);
    }
   
}

module cote_lock(){
    difference(){
        union(){
            hull(){
                cylinder(r= r1,e);
                translate([0,5,0])cylinder(r= r1,e);
            
            }
            cylinder(r= r1,e+e_porte);
        }
        translate([0, 0,-1])cylinder(r= r_vis,e+e_porte+2);
    }
   
}

translate([15,0,0]) cote();
translate([-15,0,0]) cote();
cote_lock();
