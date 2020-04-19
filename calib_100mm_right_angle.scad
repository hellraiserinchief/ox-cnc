$fn=50;
difference()
{
    union()
    {
        hull() {
            cylinder(r=4, h = 2);
            translate([100,0,0]) cylinder(r=4, h = 2);
        }
        hull() {
            cylinder(r=4, h = 2);
            translate([0,100,0]) cylinder(r=4, h = 2);
        }
        cylinder(r=4, h = 4);
        translate([100,0,0]) cylinder(r=4, h = 4);
        translate([0,100,0]) cylinder(r=4, h = 4);        
    }
    cylinder(r=1, h = 4);
    translate([100,0,0]) cylinder(r=1, h = 4);
    translate([0,100,0]) cylinder(r=1, h = 4);        
}