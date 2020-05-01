include <MCAD/nuts_and_bolts.scad>

hole_dist = 20;
corner_width=19;
corner_inset=2;
main_size=[90,7,10];
support_size=[90,7,10];
difference()
{
    cube(main_size); 
    translate([main_size.x/2-hole_dist/2,main_size.y-2,main_size.z/2]) rotate([90,0,0]) boltHole(5,MM, 10);
    translate([main_size.x/2+hole_dist/2,main_size.y-2,main_size.z/2]) rotate([90,0,0]) boltHole(5,MM, 10);
}
difference()
{
    union()
    {
        translate([0,-support_size.y+main_size.y,main_size.z]) cube(support_size);
        translate([0,-support_size.y+main_size.y,-main_size.z]) cube(support_size);
    }
    
    translate([support_size.x/2-corner_width/2+20,-corner_width+corner_inset,main_size.z]) cube([corner_width,corner_width,support_size.z]); 
    translate([support_size.x/2-corner_width/2-20,-corner_width+corner_inset,main_size.z]) cube([corner_width,corner_width,support_size.z]);
    
    translate([support_size.x/2-corner_width/2+20,-corner_width+corner_inset,-main_size.z]) cube([corner_width,corner_width,support_size.z]); 
    translate([support_size.x/2-corner_width/2-20,-corner_width+corner_inset,-main_size.z]) cube([corner_width,corner_width,support_size.z]);
}
