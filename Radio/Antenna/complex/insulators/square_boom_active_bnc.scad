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

demo_sq_b_conn_bnc = false;

include <../../connectors/connector_bnc_punch_mask.scad>
include <../../complex/insulators/square_boom_active.scad>

if (demo_sq_b_conn_bnc){ 
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    $boom_size = 10;
    $wall_width = 1.3;
    $element_holder_length = 40;
    $element_radius = 3;
    $spacer_width = 5;

    square_boom_active_bnc(); 
}

module square_boom_active_bnc()
{
    sw = $spacer_width;
    l = $element_holder_length;
    l2 = $element_holder_length/2;
    center = $boom_size/2 + $element_radius + $wall_width; 
    ww = $wall_width;

    // side wall length
    side_len = $element_radius + 5;
    side_height = $element_radius *2 + $wall_width * 2;

    // vertical wall
    vertical_wall_h = 25;
    vertical_wall_l = 25;

    // vertical wall offset
    vw_dz = $boom_size/2;
    vw_dy = vertical_wall_l/2;
    bnc_z = 9.25 + $boom_size/2 + $wall_width;
    bnc_x = 10 + $wall_width;    
    
   
    difference()
    {
        union(){
            // horizontal wall
            translate([0,-vw_dy,vw_dz]) cube([side_len,vertical_wall_l,$wall_width]);
            // vertical wall
            translate ([side_len, -vw_dy, vw_dz]) cube([$wall_width,vertical_wall_l,20]);
            // side 1
            translate([0,vw_dy-ww,vw_dz]) ah_side(side_len, side_height);
            // side 2
            translate([0,-vw_dy,vw_dz]) ah_side(side_len, side_height);
            // holder
            square_boom_active(35);
        }
        // substract connector
        translate([side_len + $wall_width, 0, bnc_z]) connector_bnc_punch_mask();
    }
 }
 
 module ah_side(px = 10, pz = 10){
    // plane
    py = $wall_width;
    // cylinder
    rr = $element_radius + $wall_width;
    cdx = 0; cdy = -1; cdz = rr;

    difference(){
        cube([px, py, pz]);        
        translate([cdx,cdy,cdz]){
            rotate([90,90,180]) {
                cylinder(3, rr, rr);
            }
        }
    }
}


