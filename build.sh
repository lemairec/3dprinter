#!/usr/bin/env python

openscad="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"
slic3r="/Applications/Slic3r.app/Contents/MacOS/slic3r"

rm -rf res
mkdir res
mkdir res/stl
mkdir res/gcode

for i in "endstop-holder" "xy_middle" "xy_corner" "palier" "z" "z_stop"
do
    echo $i
    $openscad src/$i.scad -o res/stl/$i.stl
    $slic3r --load inc/config.ini -o res/gcode/$i res/stl/$i.stl
    python inc/gcode.py res/gcode/$i
done

