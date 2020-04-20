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

h = 45;
w = 130;
d = 80;
ww = 3;
stand = true;
screw_diameter = 3;
skirt = 3;
radius = 6;

difference()
{
    // housing
    box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius);
    banana_connector();
    voltmeter_hole();
    switch_hole();
    charger_hole();
}
//banana_connector();

module box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    translate([0, 5, 0])
    box_rounded_walls(w,d,h,ww,stand,screw_diameter,skirt,radius);
    translate([0,-d-5,0])
    box_rounded_lid(w,d,h,ww,stand,screw_diameter,skirt,radius);
}

module banana_connector()
{
    bc_l = 19;// distance between holes
 
    translate([0, 25, ((h-22)/2)])
    {
    translate([-2, 0, 0])
        banana_connector_pin();
    translate([-2, 0, bc_l])
        banana_connector_pin();
    }
}

module banana_connector_pin()
{
    bc_r = 3;//hole radius

        rotate([0, 90, 0])
{
    cylinder(20, bc_r, bc_r);
    translate([0, 0, 1])
        cylinder(2, bc_r*2, bc_r*2);
    translate([0, 0, 4])
        cylinder(2, bc_r*2, bc_r*2);
}
}

module switch_hole()
{
    translate([-2, 53, 24])
    cube([12, 19 , 10]);
}

module charger_hole()
{
    translate([-2, 43, 30])
    rotate([0, 90, 0])
    cylinder(10, 4, 4);
}

module voltmeter_hole()
{
    translate([-2, 40, 8])
    cube([10, 23 , 10]);
}
