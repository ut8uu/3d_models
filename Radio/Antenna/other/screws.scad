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

demo_screws = false;

if (demo_screws){
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees

    screw_m25(15);
    translate([0,0,5]) screw_m3(15);
    translate([0,0,12]) screw_m4(15);
    translate([0,0,21]) screw_m5(15);
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

module screw(r1 = 1, r2 = 2, l = 5, h = 1){
    r = r1;
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
