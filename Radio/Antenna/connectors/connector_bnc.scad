// MIT License

// Copyright (c) 2018 ut8uu

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

demo_conn_bnc = false;

include <../other/hole.scad>

if (demo_conn_bnc){ 
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    connector_bnc(); 
    }

module hole_m29(){
    hole(1.45, 4);
}

module connector_bnc(){
    h = 18.5;
    h2 = h/2;
    screw_offset = 12.7;
    so2 = screw_offset/2;
    
    color("Fuchsia")
    union(){
        difference(){
            translate([0,-h2,-h2]) cube([2,h,h]);    
            translate([-1,-so2,-so2]) hole_m29();
            translate([-1,so2,so2]) hole_m29();
            translate([-1,-so2,so2]) hole_m29();
            translate([-1,so2,-so2]) hole_m29();
        }
        translate([2,0,0]) rotate([0,90,0]) cylinder(13, 4.85, 4.85);
        translate([-5,0,0]) rotate([0,90,0]) cylinder(5, 4, 4);
        translate([-7,0,0]) rotate([0,90,0]) cylinder(2, 2, 2);
        translate([-9,0,0]) rotate([0,90,0]) cylinder(3.3, 1.1, 1.1);
    }
}
