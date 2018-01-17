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

// global variables

// set the variable below to see the box in action
screw_stand_demo = false;

if (screw_stand_demo)
{
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    
    w=5;
    h=25;
    hd=3; // diameter of hole
    screw_stand("square", w, h, hd);
    
    translate([-w*2, 0, 0]) screw_stand("round", w, h, hd);
}

module screw_stand(form, width, height, hole_diameter)
{
    difference()
    {
        union()
        {
            if (form == "square")
            {
                translate([-width/2, -width/2, 0]) cube([width, width, height]);
            }
            
            if (form == "round")
            {
                cylinder(height, width/2, width/2);
            }
        }
        translate([0,0, -0.1]) 
        cylinder(height+0.2, hole_diameter/2, hole_diameter/2);
    }
}

