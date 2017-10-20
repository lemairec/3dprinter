include <../config.scad>

h = 3;
 $fn=100;
 
rayon = 16;
rayon2 = 5;
l = 25;

difference(){
    union(){
        translate([-40, 0, 0]) cube([80, 4, 10]);
        translate([0,l,rayon2-1]) rotate_extrude() translate([rayon,0,0]) circle (rayon2);

        for(i = [0,1]){
            mirror([i,0,0])hull(){
                translate([rayon,l,rayon2-1]) rotate([90, 0, 0]) cylinder(2, rayon2, rayon2);
                translate([20, 0, 0])cube([10, 3, 10]);
            }
        }
     }
     translate([-100, 0, -20]) cube([200, 200, 20]);
     translate([0, l+ rayon, 5]) rotate([0,30,0])cube([3, 40, 40], center= true);
     for(i = [0,1]){
        mirror([i,0,0]) translate([-35,10,5]) rotate([90, 0, 0]) m3(20);
     }
}