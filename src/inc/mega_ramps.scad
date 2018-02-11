include <../config.scad>

module fixation_mega_2d(){
    translate([-40,48/2+5])rotate([0,0,90])fixation_2d();
    translate([35,48/2+5])rotate([0,0,90])fixation_2d();
    translate([-40-7,-48/2-5])rotate([0,0,90])fixation_2d();
    translate([35,-48/2-5])rotate([0,0,90])fixation_2d();
}

module fixation_mega_2d_vis(){
    r = 3/2;
    translate([-40,48/2]) circle(r);
    translate([35,48/2])  circle(r);
    translate([-40-7,-48/2]) circle(r);
    translate([35,-48/2]) circle(r);
}

fixation_mega_2d_vis();