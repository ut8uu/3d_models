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
    $box_stand = true;
    $box_stand_screw_diameter = 3;
    $box_lid_skirt = 5;
    
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

    translate([5,0,0])
    {
        difference()
        {
            union()
            {
                cube([w,d,ww]);
                difference()
                {
                    translate([ww+t,ww+t,ww]) cube ([w-ww*2-t*2, d-ww*2-t*2, h2]);
                    translate([ww*2,ww*2,ww-0.9]) cube([w-ww*4, d-ww*4, h2+2]);
                }
                translate([2*ww, 2*ww, ww]) cube([bsw, bsw,5*ww]);
                translate([w-2*ww-bsw, 2*ww, ww]) cube([bsw, bsw,5*ww]);
                translate([2*ww, d-bsw-2*ww, ww]) cube([bsw, bsw,5*ww]);
                translate([w-2*ww-bsw, d-bsw-2*ww, ww]) cube([bsw, bsw,5*ww]);
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
    h = $box_h;
    d = $box_d;

    // hole in lid for th screw head
    cr1 = $box_stand_screw_diameter/2;
    
    translate([bsw/2+cr1, bsw/2+cr1, -1]) hole_for_screw_head();
    translate([w -bsw/2 - cr1, bsw/2+cr1, -1]) hole_for_screw_head();
    translate([bsw/2+cr1, d-bsw/2-cr1, -1]) hole_for_screw_head();
    translate([w -bsw/2 - cr1, d-bsw/2-cr1, -1]) hole_for_screw_head();
}

module hole_for_screw_head()
{
    ww = $box_wall_thickness;
    
    cr0 = ($box_stand_screw_diameter + 4)/2;
    cr1 = $box_stand_screw_diameter/2;
    ch0 = ww+2;
    ch1 = $box_lid_skirt + ww + 2;

    cylinder(ch0, cr0, cr0);
    cylinder(ch1, cr1, cr1);
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
        bsw = $box_stand_screw_diameter + 6 + 2*ww;
        bsh = $box_h-$box_lid_skirt;
        if ($box_stand){
            box_stand_6611BC6372B84EC5B78C8F90C1A866CB(0, 0, 0, bsh);
            box_stand_6611BC6372B84EC5B78C8F90C1A866CB(w-bsw, 0, 0, bsh);
            box_stand_6611BC6372B84EC5B78C8F90C1A866CB(0, d-bsw, 0, bsh);
            box_stand_6611BC6372B84EC5B78C8F90C1A866CB(w-bsw, d-bsw, 0, bsh);
        }
    }
    
}

module box_stand_6611BC6372B84EC5B78C8F90C1A866CB(dx, dy, dz, h)
{
    ww = $box_wall_thickness;
    w = $box_stand_screw_diameter + 6;
    r = $box_stand_screw_diameter/2;

    translate([dx+ww,dy+ww,dz])
        difference(){
            cube([w,w,h]);
            translate([w/2, w/2, h/2])
                cylinder(h/2+1,r,r);
        }
}


