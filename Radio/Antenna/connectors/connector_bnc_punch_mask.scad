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

demo_conn_bnc_mask = false;

include <../other/hole.scad>

if (demo_conn_bnc_mask){ 
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    $wall_width = 1.2;
    connector_bnc_punch_mask(); 
    }

module hole_m3(){
    hole(1.5, $wall_width + 0.2);
}

module connector_bnc_punch_mask(){
    screw_offset = 12.7;
    so2 = screw_offset/2;
    
    w = $wall_width + 0.2;
    ww = $wall_width + 0.1;
    union(){
        translate([-ww,-so2,-so2]) hole_m3();
        translate([-ww,so2,so2]) hole_m3();
        translate([-ww,-so2,so2]) hole_m3();
        translate([-ww,so2,-so2]) hole_m3();
        translate([-ww,0,0]) hole(5,w);
    }
}
