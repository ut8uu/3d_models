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

include <screw_stand.scad>
include <screws.scad>
include <plates.scad>

// set the variable below to see the box in action
box_demo = false;

if (box_demo)
{
    // Global resolution
    $fs = 0.1;  // Don't generate smaller facets than 0.1 mm
    $fa = 5;    // Don't generate larger angles than 5 degrees
    
    h = 20;
    w = 50;
    d = 60;
    ww = 1;
    stand = true;
    screw_diameter = 3;
    skirt = 3;
    radius = 5;
    
    translate([0, 10, 0]) box_square(w,d,h,ww,stand,screw_diameter,skirt);
    translate([-5-w, -d-10, 0]) box_rounded(w,d,h,ww,stand,screw_diameter,skirt,radius);
}

module box_square(w,d,h,ww,stand,screw_diameter,skirt)
{
    box_square_walls(w,d,h,ww,stand,screw_diameter,skirt);
    box_square_lid(w,d,h,ww,stand,screw_diameter,skirt);
}

module box_rounded(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    box_rounded_walls(w,d,h,ww,stand,screw_diameter,skirt,radius);
    translate([w+10,0,0])
    box_rounded_lid(w,d,h,ww,stand,screw_diameter,skirt,radius);
}

module box_rounded_walls(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    t = 0.1;
    delta = 0.2;
    
        translate([w/2,d/2,0]) difference()
        {
            plate_square_rounded(w,d,h-ww,radius);
            translate([0,0,ww]) 
                plate_square_rounded(w-ww*2,d-ww*2,h-ww+1,radius-ww);

        }
        
        if (stand){
            bsw = screw_diameter + 6;
            bsh = h-skirt-ww-t;
            bsdx = bsw/2+ww*2;
            bsdy = bsw/2+ww*2;

            translate([bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            translate([w-bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            
            translate([bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            translate([w-bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
        }
}    

module box_rounded_lid(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    h2 = skirt;
    t = 0.1; // tolerance
    bsw = screw_diameter + 6;

    bsh = h2-t; // box stand height
    delta = 0.2; 

        difference()
        {
            union()
            {
                translate([w/2,d/2,0]) 
                union()
                {
                    plate_square_rounded(w,d,ww,radius);
                    difference()
                    {
                        plate_square_rounded(w-ww*2-t,d-ww*2-t,bsh+ww,radius);
                        translate([0,0,-1]) 
                          plate_square_rounded(w-ww*4,d-ww*4,bsh+2+ww,radius);
                    }
                }
                if (stand)
                    {
                    bsdx = bsw/2+ww+t+delta;
                    bsdy = bsw/2+ww+t+delta;

                    translate([bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    translate([w-bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    
                    translate([bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    translate([w-bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                }
            }
            if (stand)
            {
                holes_in_lid(bsw,w,d,h,ww,screw_diameter,skirt,delta);
            }
        }
}


module box_square_lid(w,d,h,ww,stand,screw_diameter,skirt)
{
    h2 = skirt;
    t = 0.1; // tolerance
    bsw = screw_diameter + 6;

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
                if (stand){
                    bsdx = bsw/2+ww+t;
                    bsdy = bsw/2+ww+t;

                    translate([bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    translate([w-bsdx,bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    
                    translate([bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                    translate([w-bsdx,d-bsdy,0]) 
                        screw_stand("round", bsw, bsh+ww, screw_diameter);
                }
            }
            if (stand)
            {
                holes_in_lid(bsw,w,d,h,ww,screw_diameter,skirt,0);
            }
        }
    }
}

module holes_in_lid(bsw,w,d,h,ww,screw_diameter,skirt,delta)
{
    t = 0.1;
    
    bsdx = bsw/2+ww+t+delta;
    bsdy = bsw/2+ww+t+delta;
    
    translate([bsdx, bsdy, -1]) hole_for_screw_head(ww,screw_diameter,10);
    translate([w-bsdx, bsdy, -1]) hole_for_screw_head(ww,screw_diameter,skirt);
    translate([bsdx, d-bsdy, -1]) hole_for_screw_head(ww,screw_diameter,skirt);
    translate([w-bsdx, d-bsdy, -1]) hole_for_screw_head(ww,screw_diameter,skirt);
}

module hole_for_screw_head(head_height,screw_diameter,rod_height)
{
    hh = head_height;
    rh = rod_height;
    cr0 = (screw_diameter + 4)/2;
    cr1 = screw_diameter/2;
    ch0 = hh+2+0.1;
    ch1 = rh + hh + 2 + 0.1;

    rotate([0, 270, 90])
    screw_hole(cr0, cr1, ch0, ch1);
}

module box_square_walls(w,d,h,ww,stand,screw_diameter,skirt)
{
    t = 0.1;
    translate([-5-w,0,0]){
        difference()
        {
            cube([w, d, h]);
            translate([ww,ww,ww])
                cube([w-ww*2, d-ww*2, h]);
        }
        
        if (stand){
            bsw = screw_diameter + 6;
            bsh = h-skirt-ww-t;
            bsdx = bsw/2+ww*2;
            bsdy = bsw/2+ww*2;

            translate([bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            translate([w-bsdx,bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            
            translate([bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
            translate([w-bsdx,d-bsdy,0]) 
                screw_stand("round", bsw, bsh, screw_diameter);
        }
    }
    
}

