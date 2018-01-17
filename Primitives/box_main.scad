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

include <screw_stand.scad>
include <screws.scad>

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
    $box_stand = true;
    $box_stand_screw_diameter = 3;
    $box_lid_skirt = 3;
    
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
    h2 = $box_lid_skirt;
    t = 0.1; // tolerance
    bsw = $box_stand_screw_diameter + 6;

    bsh = h2-t; // box stand height

    translate([5,0,0])
    {
        difference()
        {
            union()
            {
                union()
                {
                    cube([w,d,ww]);
                    difference()
                    {
                        translate([ww+t,ww+t,ww]) cube ([w-ww*2-t, d-ww*2-t, bsh]);
                        translate([ww*2,ww*2,ww-0.9]) cube([w-ww*4, d-ww*4, bsh+2]);
                    }
                }
                if ($box_stand){
                    bsw = $box_stand_screw_diameter + 6;
                    bsdx = bsw/2+ww+t;
                    bsdy = bsw/2+ww+t;

                    translate([bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, $box_stand_screw_diameter);
                    translate([w-bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, $box_stand_screw_diameter);
                    
                    translate([bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, $box_stand_screw_diameter);
                    translate([w-bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, $box_stand_screw_diameter);
                }
            }
            if ($box_stand)
            {
                holes_in_lid(bsw, ww);
            }
        }
    }
}

module holes_in_lid(bsw, ww)
{
    w = $box_w;
    d = $box_d;

    t = 0.1;
    
    bsdx = bsw/2+ww+t;
    bsdy = bsw/2+ww+t;
    
    translate([bsdx, bsdy, -1]) hole_for_screw_head();
    translate([w-bsdx, bsdy, -1]) hole_for_screw_head();
    translate([bsdx, d-bsdy, -1]) hole_for_screw_head();
    translate([w-bsdx, d-bsdy, -1]) hole_for_screw_head();
}

module hole_for_screw_head()
{
    ww = $box_wall_thickness;
    
    cr0 = ($box_stand_screw_diameter + 4)/2;
    cr1 = $box_stand_screw_diameter/2;
    ch0 = ww+2+0.1;
    ch1 = $box_lid_skirt + ww + 2 + 0.1;

    rotate([0, 270, 90])
    screw_hole(cr0, cr1, ch0, ch1);
}

module box_walls_9D04E7778521468E8EBB86C1C622761C()
{
    ww = $box_wall_thickness;
    w = $box_w - ww;
    h = $box_h;
    d = $box_d;
    t = 0.1;
    translate([-5-w,0,0]){
        difference()
        {
            cube([w, d, h]);
            translate([ww,ww,ww])
                cube([w-ww*2, d-ww*2, h]);
        }
        
        if ($box_stand){
            bsw = $box_stand_screw_diameter + 6;
            bsh = $box_h-$box_lid_skirt-ww-t;
            bsdx = bsw/2+ww-0.2;
            bsdy = bsw/2+ww-0.2;

            translate([bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, $box_stand_screw_diameter);
            translate([w-bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, $box_stand_screw_diameter);
            
            translate([bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, $box_stand_screw_diameter);
            translate([w-bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, $box_stand_screw_diameter);
        }
    }
    
}

