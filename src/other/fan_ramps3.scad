// RAMPS Fan Mount
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com> and contributors
// visit: http://www.schlotzz.com


width = 90;
heigth = 60;
e = 4;
depth = 10;

module ramps_fan_mount_cutoff_cube(width, height, depth, radius = 5)
{
    width2 = width + 30;
	union()
	{
		translate([-width/2, 0, 0]) cube([width, height - radius, depth]);
        hull()
		{
			for (i = [0,1]){
				mirror([i,0,0])translate([-width2/2, 2, 0])
					cylinder(r = 2, h = depth);
            }
		}
        
		hull()
		{
			for (i = [0,1]){
				mirror([i,0,0])translate([width/2-radius, height - radius, 0])
					cylinder(r = radius, h = depth);
            }
		}
        
        for (i = [0,1]){
            mirror([i,0,0]) 
                translate([width/2-1, 4-1, 0])
                difference(){
                    cube([radius+1, radius+1, depth]);
                    translate([radius+1, radius+1, -1]) cylinder(r = radius, h = depth+2);
                }
        }
	}
}

difference(){
    ramps_fan_mount_cutoff_cube(width, heigth, depth);
    translate([0, -4, -1]) ramps_fan_mount_cutoff_cube(width-2*e, heigth, depth+2);
    
    for (i = [0,1]){
        mirror([i,0,0]) translate([width/2+10, -1, depth/2]) rotate([-90,0,0])cylinder(r=1.6, 100);
        mirror([i,0,0]) translate([72/2, -1, depth/2]) rotate([-90,0,0])cylinder(r=1.6, 100);
    }
    
    
}
//ramps_fan_mount(fanDia= 72,  fanHoleDia = 3.1, fanHoleDist = 70, $fn = 32);