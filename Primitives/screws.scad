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

// screws and holes are placed along the axis X
// and centered on the axis X

// history of changes
// 20.01.2018 initial commit
// 28.01.2018 added cone head bolts and corresponding punch objects
// 30.01.2018 removed color of punch object
// 30.01.2018 fixed bug with incorrect bolt length

demo_screws = false;

if (demo_screws){
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees

    screw_m25(15);
    translate([0,0,5]) screw_m3(15);
    translate([0,0,12]) screw_m4(15);
    translate([0,0,21]) screw_m5(15);
    
    translate([0, 10, 0])
    {
        screw_hole_m25(15);
        translate([0,0,5]) screw_hole_m3(15);
        translate([0,0,12]) screw_hole_m4(15);
        translate([0,0,21]) screw_hole_m5(15);
    }
    
    translate([0, -10, 0])
    {
        translate([0,0,5]) screw_m3_cone(15);
        translate([0,0,12]) screw_m4_cone(15);
        translate([0,0,21]) screw_m5_cone(15);
    }
    
    translate([0, -20, 0])
    {
        translate([0,0,5]) screw_hole_m3_cone(15);
        translate([0,0,12]) screw_hole_m4_cone(15);
        translate([0,0,21]) screw_hole_m5_cone(15);
    }
}

module screw_m25(l = 5){
    screw(1.25, 2.25, l, 1.6);
}

module screw_m25x5(){
    screw_m25(5);
}

module screw_m3(l = 5){
    screw(1.5, 2.75, l, 2);
}

module screw_m4(l = 5){
    screw(2, 3.5, l, 2.6);
}

module screw_m5(l = 5){
    screw(2.5, 4.25, l, 3.3);
}

module screw_m3_cone(l = 5){
    screw_cone(1.5, 2.75, l, 2);
}

module screw_m4_cone(l = 5){
    screw_cone(2, 3.5, l, 2.6);
}

module screw_m5_cone(l = 5){
    screw_cone(2.5, 4.25, l, 3.3);
}


// holes
module screw_hole_m25(l=5)
{
    t = 0.2; // tolerance
    screw_hole(1.25+t, 2.25+t, l, 1.6);
}

module screw_hole_m3(l = 5){
    t = 0.2; // tolerance
    screw_hole(1.5+t, 2.75+t, l, 2);
}

module screw_hole_m3_cone(l = 5){
    t = 0.2; // tolerance
    screw_hole_cone(1.5+t, 2.75+t, l, 2);
}

module screw_hole_m4(l = 5){
    t = 0.2; // tolerance
    screw_hole(2+t, 3.5+t, l, 2.6);
}

module screw_hole_m4_cone(l = 5){
    t = 0.2; // tolerance
    screw_hole_cone(2+t, 3.5+t, l, 2.6);
}

module screw_hole_m5(l = 5){
    t = 0.2; // tolerance
    screw_hole(2.5+t, 4.25+t, l, 3.3);
}

module screw_hole_m5_cone(l = 5){
    t = 0.2; // tolerance
    screw_hole_cone(2.5+t, 4.25+t, l, 3.3);
}



module screw(r1 = 1, r2 = 2, l = 5, h = 1){
    r = r1;
    l = l - h;
    bx = h; by = r2*2+1; bz = 0.6;

    color("lime")
    rotate([45,0,0])
    difference(){
        union(){
            rotate([0,90,0]) 
                cylinder(l, r1, r1);
            translate([l, 0, 0])
                rotate([0,90,0])
                    cylinder(h, r2, r2);
        }
        
        translate([l+h-1,-by/2,-bz/2]) 
            cube([bx, by, bz]);
    }
}

module screw_cone(r1 = 1, r2 = 2, l0 = 5, h = 1){
    r = r1;
    l = l0 - h;
    bx = h; by = r2*2+1; bz = 0.6;

    color("lime")
    rotate([45,0,0])
    difference(){
        union(){
            rotate([0,90,0]) 
                cylinder(l, r1, r1);
            translate([l, 0, 0])
                rotate([0,90,0])
                    cylinder(h, r1, r2);
        }
        
        translate([l+h-1,-by/2,-bz/2]) 
            cube([bx, by, bz]);
    }
}

module screw_hole(r1 = 1, r2 = 2, l0 = 5, h = 1){
    l = l0 - h;
    rotate([45,0,0])
    difference(){
        union(){
            rotate([0,90,0]) 
                cylinder(l, r1, r1);
            translate([l, 0, 0])
                rotate([0,90,0])
                    cylinder(h, r2, r2);
        }
    }
}

module screw_hole_cone(r1 = 1, r2 = 2, l = 5, h = 1){
    l = l - h;
    rotate([45,0,0])
    union(){
        rotate([0,90,0]) cylinder(l+0.1, r1, r1);
        translate([l, 0, 0]) rotate([0,90,0]) cylinder(h, r1, r2);
    }
}
