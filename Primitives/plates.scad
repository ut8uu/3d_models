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

// set the variable below to see the box in action
plates_demo = true;

if (plates_demo)
{
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees

    translate([30, 0, 0]) plate_square(50, 40, 10);
    translate([-30, 0, 0]) plate_square_rounded(50, 40, 10, 10);
}

module plate_square(width, depth, height)
{
    plate_4529794C958649EDBED3F456D2B65E87(width, depth, height, 0);
}

module plate_round(radius, height)
{
    plate_4529794C958649EDBED3F456D2B65E87(radius, radius, height, radius);
}

module plate_square_rounded(width, depth, height, corner_radius)
{
    plate_4529794C958649EDBED3F456D2B65E87(width, depth, height, corner_radius);
}

module plate_4529794C958649EDBED3F456D2B65E87(width, depth, height, corner_radius)
{
    r = corner_radius;
    w = width; h = height; d = depth;
    w2 = w/2-r; d2 = d/2-r; h2 = h/2;
    translate([-width/2, -depth/2, 0])
    
    if (corner_radius == 0)
    {
        // simple box
        cube([width, depth, height]);
    }
    else
    {
        translate([r, r, 0]) cylinder(h, r,r);
        translate([w-r, r, 0]) cylinder(h, r,r);
        translate([r, d-r, 0]) cylinder(h, r,r);
        translate([w-r, d-r, 0]) cylinder(h, r,r);
        
        translate([r, 0, 0]) cube([w-r*2, r,h]);
        translate([r, d-r, 0]) cube([w-r*2, r,h]);
        
        translate([0,r,0]) cube([r, d-r*2, h]);
        translate([w-r,r,0]) cube([r, d-r*2, h]);
        
        translate([r,r,0]) cube([w-2*r,d-2*r,h]);
    }
}