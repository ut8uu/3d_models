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


// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

demo_clamp1 = false;

include <../../../primitives/screws.scad>

if (demo_clamp1)
{
    clamp1(3, 20, 55, 3, 2);
}

// r - radius of element
// h - height of the clamp
// w - width of the flat part
// wt - wall thickness
// n - number of holes for screws
module clamp1(r, h, w, wt, n)
{
    wtx2 = wt*2;
    
    difference()
    {
      union()
      {
      translate([-h/2, r, -(wtx2+2)/2])
        difference()
        {
          cube([h, w, wtx2+2]);
          translate([-h+1, 12, -wt+1]) cube([h*2, w, wt*2]);
          translate([-h/2, 0, wt]) cube([h*2, w*2, 2]);
        }
      translate([-h/2, 0, 0])
        rotate([0, 90, 0])
          difference()
          {
          cylinder(h, r+wt, r+wt);
          translate([0, 0, -h/2])
          cylinder(h*2, r, r);
          }
        }
        translate([-h/2-1, -1, -1]) cube([h*2+1, w, 2]);
        
        translate([-15/2+2, 105/2, -6.3])
          rotate([0,270,0])
            screw_hole_m3_cone(wt*10);
        
        translate([15/2-2, 105/2, -6.3])
          rotate([0,270,0])
            screw_hole_m3_cone(wt*10);
        
        translate([0, 18/2, -wt*2])
          rotate([0,270,0])
            screw_hole_m3_cone(wt*20);
    }
}
