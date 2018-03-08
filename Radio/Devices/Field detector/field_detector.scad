// MIT License

// Copyright (c) 2018 Sergey Usmanov, UT8UU

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

demo_field_detector = true;

include <../../../Primitives/box_main.scad>
include <../../../radio/antenna/connectors/connector_bnc_punch_mask.scad>

// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

h = 30;
w = 95;
d = 70;
ww = 2;
stand = true;
screw_diameter = 3;
skirt = 3;
radius = 6;

difference()
{
    // housing
    box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius);
    // led holes
    translate([1.7+ww+7, -5-15-40+3, 0]) led_holes();
    // hole for potentiometer
    translate([-0.5, 30, 19.25]) rotate([0, 90, 0]) cylinder(ww+1, 3.25, 3.25);
    // hole for bnc connector
    $wall_width = ww*3;
    translate([ww*2, 50, 15])connector_bnc_punch_mask();
}

wh = h - 4*ww;
bc_x = 67;
b_x = 18; // battery thickness
// battery compartment
// transverse wall 
translate([bc_x-ww, 5, ww]) cube([ww,d,wh]);
// ribs
translate([bc_x+b_x, 5+d/3, ww])
cube([w-bc_x-ww-b_x, ww, wh]);
translate([bc_x+b_x, 5+d/1.5, ww])
cube([w-bc_x-ww-b_x, ww, wh]);

module led_holes()
{
    led_offset = 6.5;
    led_hole(0);
    led_hole(led_offset);
    led_hole(led_offset*2);
    led_hole(led_offset*3);
    led_hole(led_offset*4);
    led_hole(led_offset*5);
    led_hole(led_offset*6);
}
module led_hole(dx)
{
    translate([dx, 0, -0.5])
        cylinder(ww+1, 1.7, 1.7);
}  

module box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    translate([0, 5, 0])
    box_rounded_walls(w,d,h,ww,stand,screw_diameter,skirt,radius);
    translate([0,-d-5,0])
    box_rounded_lid(w,d,h,ww,stand,screw_diameter,skirt,radius);
}
