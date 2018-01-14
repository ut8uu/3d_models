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

demo_sqba = false;

if (demo_sqba) { 
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    $boom_size = 10;
    $wall_width = 1.3;
    $element_holder_length = 20;
    $element_radius = 3;
    $spacer_width = 3;
    square_boom_active(40); 
}

include <square_boom_passive.scad>

module square_boom_active(holder_length = 40){
    w = $spacer_width;
    ww = $wall_width;
    bs = $boom_size;
    
    // hole for wires in element holder
    hole_x = ($element_radius + ww)*2;
    hole_y = 10;
    hole_z = $element_radius + ww + 1;
    hole_dx = -hole_x/2;
    hole_dy = -hole_y/2;
    hole_dz = bs/2 + $element_radius + ww;

    // divider
    d_dx = 0; // x offset
    d_dy = 0;
    d_dz = bs/2; // z offset

    difference(){
        union(){
            square_boom_passive(holder_length);
            // divider
            translate([d_dx,d_dy,d_dz]) ah_divider();
        }
        // make hole for wires
        translate([hole_dx,hole_dy,hole_dz]) cube([hole_x,hole_y,hole_z]);
    }
}

module ah_divider(){
    er = $element_radius;
    ww = $wall_width;
    r = er + ww;
    w = $spacer_width;

    translate([0,w/2,er+ww])
    rotate([0,-90,90])
    //translate([0, -ww, -er])
        cylinder(w,r,r);
}
