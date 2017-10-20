jhead_vis = 4;

jhead_h01 = 4;
jhead_h02 = 10;
jhead_h0 = 18;//7//18
jhead_h1 = 33;
jhead_h2 = 13;
jhead_h3 = 5;

module jhead(){
    cylinder(jhead_h0, r=16.7/2);
    translate([0, 0, jhead_h0])  cylinder(jhead_h1, 25/2, 25/2);
    translate([-8, -7, jhead_h0+jhead_h1])  cube([16, 17, 13]);
    translate([0, 0, jhead_h0+jhead_h1+jhead_h2])  cylinder(5, 8/2, 0.2);
    translate([0, 0, jhead_h0+jhead_h1+jhead_h2+jhead_h3])  cylinder(0.1, 30, 30);
}

module jhead_vis(r_nuts = 1.6, l = 300){
    jhead();
    translate([0, 12.5/2 + r_nuts, 4 + r_nuts])rotate([0,90,0]) cylinder(r = r_nuts, l, center = true);
    translate([0, -12.5/2 - r_nuts, 4 + r_nuts])rotate([0,90,0]) cylinder(r = r_nuts, l, center = true);
}
