include <config.scad>

//21
//21.5

pcb = 217;
vitre = 204;
e = 3;

temp = (pcb-vitre)/2+ e;

$fn = 100;

h = 3;
h1 = 2.0;
h2 = 3.4;
r_h2 = 0.6;

l1 = 7 + h;
l2 = 15;

rotate([0, 0, -45]) difference(){
    union(){
        translate([-pcb/2 - e, 0, 0]) cube([pcb + e + e, h + h1 + h2 + h, h]);
        translate([-pcb/2 - e , 0, 0]) cube([pcb + e + e, h, l2]);
        translate([-pcb/2 - e, h + h1 + h2, 0]) cube([pcb + e + e, h, l1]);
        translate([-pcb/2 - e, h + h1 + h2, l1 - 1]) rotate([0,90,0]) cylinder(pcb + e + e, r_h2, r_h2);
        translate([-pcb/2 - e, h + h1 + h2 + h, l1]) rotate([0, 0, -90]) corner(e, h, pcb + h + h);
        
        translate([-pcb/2 + 10, (h + h1 + h2 + h)/2, 0]) cylinder(0.3, 20, 20);
        translate([pcb/2 - 10, (h + h1 + h2 + h)/2, 0]) cylinder(0.3, 20, 20);
         
        for (i = [0 : 1]){
            //mirror([i, 0, 0]) translate([-pcb/2, 0, 10]) corner(25, 25, e);
            mirror([i, 0, 0]) translate([pcb/2, 0, 0]) cube([e, h1 + h, l2]);
            mirror([i, 0, 0]) translate([vitre/2, h + h1, 0]) cube([temp, h2 + h, l2]);
            //mirror([i, 0, 0]) translate([-vitre/2, h + h1 + h2, 10]) corner(20, 20, h);
            //mirror([i, 0, 0]) translate([-vitre/2 - 5, h + h1 + h2 + h, 35]) rotate([-45, 0, -90]) corner(h, h, 35);
            
            //mirror([i, 0, 0]) translate([-202/2 - 5, h + h1, 35]) rotate([0, 0, 0]) corner(h, h,  + h2 + h);
        }
        
        
    }
    for (i = [0 : 1]){
            mirror([i, 0, 0]) translate([-210/2, 0, h + 2.5]) rotate([-90, 0, 0]) m3(20);
            mirror([i, 0, 0]) translate([-210/2, 0, h + 2.5]) rotate([-90, 0, 0]) cylinder(h, 4.6, 4.6);
        }
    
    //translate([-70, -2, -2]) cube([200,200,200]);
    /*union(){
        translate([0, 0, 0]) cube([25, 3, 20]);
        translate([0, 0, 20]) corner(25, 25, 3);
        translate([0, 3, 0]) cube([25, h1, 10]);
        translate([0, 3 + h1, 0]) cube([25, h2, 15]);
        translate([0, 3 + h1 + h2, 0]) cube([25, 3, 20]);
        translate([0, 3 + h1 + h2, 20]) corner(25, 25, 3);
        translate([0, 0, 0]) cube([3, 13, 45]);
        
    }*/
}

//%translate([-100, -100, -1]) cube([200,200, 1]);
