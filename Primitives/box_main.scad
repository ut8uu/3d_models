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
// $box_w - width (x)
// $box_d - depth (y)
// $box_h - height (z)
// $box_wall_thickness - thickness of the box' wall

// set the variable below to see the box in action
box_demo = true;

if (box_demo)
{
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    
    $box_h = 30;
    $box_w = 50;
    $box_d = 60;
    $box_wall_thickness = 1;
    
    box_main();
}

module box_main()
{
    box_walls_9D04E7778521468E8EBB86C1C622761C();
    box_lid_163028402DBA46F1A57207ED46D87103();
}

module box_lid_163028402DBA46F1A57207ED46D87103()
{
    w = $box_w;
    h = $box_h;
    d = $box_d;
    ww = $box_wall_thickness;
    h2 = 5;

    translate([5,0,0])
    {
        cube([w,d,ww]);
        difference()
        {
            translate([ww,ww,ww])
                cube ([w-ww*2, d-ww*2, h2]);
            translate([ww*2,ww*2,ww-1])
                cube([w-ww*4, d-ww*4, h2+2]);
        }
    }
}


module box_walls_9D04E7778521468E8EBB86C1C622761C()
{
    w = $box_w;
    h = $box_h;
    d = $box_d;
    ww = $box_wall_thickness;
    translate([-5-w,0,0]){
        difference()
        {
            cube([w, d, h]);
            translate([ww,ww,ww])
                cube([w-ww*2, d-ww*2, h]);
        }
    }
}


