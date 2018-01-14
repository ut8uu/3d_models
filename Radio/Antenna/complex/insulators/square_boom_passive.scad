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

demo_sqbp = false;

if (demo_sqbp) { 
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    $boom_size = 10;
    $wall_width = 1.3;
    $element_radius = 3;
    square_boom_passive(20); 
}


include <../../other/rod.scad>
include <../../other/boom_square.scad>

module square_boom_passive(holder_length){
    union(){
        boom_len = 100;

        difference(){    
            body_square(9);
            boom_square(boom_len);
        }

        bottom = $boom_size/2;
        center = bottom + $element_radius + $wall_width;    
        dx = 0;
        dy = 20;//$element_holder_length/2;
        dz = center;

        ww = $wall_width;
        bs = $boom_size;
        
        // hole for wires in element holder
        hole_x = ($element_radius + ww)*2;
        hole_y = 10;
        hole_z = $element_radius + ww + 1;
        hole_dx = -hole_x/2;
        hole_dy = -hole_y/2;
        hole_dz = bs/2 + $element_radius + ww;
        
        difference(){
            body_cylinder(holder_length);
            translate([0,25,dz]) rod($element_radius, holder_length*2);
        }
    }
}

module body_square(object_length){
    body_cube_half = ($boom_size+2*$wall_width)/2;

    dx = -object_length/2;
    dy = -body_cube_half;
    dz = -body_cube_half;
    x = object_length;
    y = 2*$wall_width+$boom_size;
    z = 2*$wall_width+$boom_size;
    
    translate([dx, dy, dz]){
        cube([x, y, z]);
    }
}

module body_cylinder(holder_length){
    bottom = $boom_size/2;
    center = bottom + $element_radius + $wall_width;    

    rr = $element_radius + $wall_width;
    dx = 0;
    dy = holder_length/2;
    dz = center;
    
    translate([dx,dy,dz]){
        rotate([90,90,0]) {
            cylinder(holder_length, rr, rr);
        }
    }
}

