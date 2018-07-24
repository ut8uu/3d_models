include <../../Primitives/box_main.scad>
// Global resolution
$fs = 0.1;  // Don't generate smaller facets than 0.1 mm
$fa = 5;    // Don't generate larger angles than 5 degrees

brx_demo = false;

if (brx_demo)
{
    h = 30;
    w = 95;
    d = 70;
    ww = 2;
    stand = true;
    screw_diameter = 3;
    skirt = 3;
    radius = 6;

    translate([0, 5, 0])
        box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius);
    translate([0,-d-5,0])
        lid_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius);

}

module box_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    box_rounded_walls(w,d,h,ww,stand,screw_diameter,skirt,radius);
}
module lid_rounded_x(w,d,h,ww,stand,screw_diameter,skirt,radius)
{
    box_rounded_lid(w,d,h,ww,stand,screw_diameter,skirt,radius);
}
