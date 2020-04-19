include <openscad-utils/extrusions/accessories_2020.scad>;
include <MCAD/nuts_and_bolts.scad>

$fn = 100;
size = [25+10,30,25];
tol = 0.15;
switch_size = [6.5+2*tol, 19.90+tol, 9.7+tol];
width = [4,size.y-switch_size.y,0];

//v_slot_limit_switch_bolt();
//v_slot_limit_switch();

//wrap_2020(size,0,4);

//switch_gaps();
//cube(switch_size);
z_limit_switch();

module switch_gaps()
{
    height = size.z;
    pin_gap = 4;
    wire_d = 1.65;
    cube(switch_size);
    //switch pins
    cube([switch_size.x,pin_gap,switch_size.z+6]);
    translate([0,switch_size.y-pin_gap,0]) cube([switch_size.x,pin_gap,switch_size.z+6]);
    translate([0,switch_size.y/2-pin_gap/2,0]) cube([switch_size.x,pin_gap,switch_size.z+6]);
    cube([switch_size.x+10,wire_d,switch_size.z+height]);
    translate([0,switch_size.y-wire_d,0]) cube([switch_size.x+10,wire_d,switch_size.z+height]);
    //holes should be here
     translate([-switch_size.z/2,switch_size.y/2+5,6.9]) rotate([0,90,0]) cylinder(r=3/2,h=2*switch_size.z);
    translate([-switch_size.z/2,switch_size.y/2-5,6.9]) rotate([0,90,0]) cylinder(r=3/2,h=2*switch_size.z);
        //#translate([base_size.x/2-5,0,-1.5*switch_size.z]) rotate([0,90,0]) cylinder(r=3/2,h=2*switch_size.z);
    
}

module z_limit_switch()
{
    r1 = 5/2;
    r2 = 8/2;
    peg_dist = 60;//60+r1+r2;
    peg_h = 3.8;
    extra_side = 2;
    base_size = [peg_dist+extra_side, 20, 2];
    #cube(base_size);
    translate([r1+extra_side/2,base_size.y/2,base_size.z]) cylinder(r=r1,h=peg_h);
    translate([base_size.x-r2-extra_side/2,base_size.y/2,base_size.z]) cylinder(r=r2,h=peg_h);
    
    difference() {
        translate([base_size.x/2-switch_size.y/2-10/2,0,-switch_size.z]) cube([switch_size.y+10,base_size.y,switch_size.z]);
        
       translate([base_size.x/2+switch_size.y/2,0,0]) rotate([0,90,90]) switch_gaps();
        
       // #translate([base_size.x/2+5,0,-1.5*switch_size.z]) cylinder(r=3/2,h=2*switch_size.z);
       // #translate([base_size.x/2-5,0,-1.5*switch_size.z]) cylinder(r=3/2,h=2*switch_size.z);
    }
}

module v_slot_limit_switch()
{
    edge_bump_dist = 3;
    hole_thk = METRIC_BOLT_CAP_DIAMETERS[3];
    switch_recess = 5;
    M5_hole_thk = 2;
    difference() {
        union()
        {
            wrap_2020(size,0,1,2);
            translate([size.x/2-width.x/2-switch_recess,-switch_size.y/2-width.y/2,0]) cube( switch_size + width );
        }
        translate([-size.x+10,size.y/2-10,0]) cube(size);
        translate([-size.x+10,-2*size.y/2-10,0]) cube(size);
        translate([size.x/2-width.x/2-switch_recess,-switch_size.y/2-width.y/2,0]) translate([width.x/2,width.y/2,width.z/2]) switch_gaps();
        #translate([0,-switch_size.y/2+5,width.z/2+switch_size.z-edge_bump_dist]) rotate([0,90,0]) cylinder(r=3/2,h=size.x);
        #translate([0,switch_size.y/2-5,width.z/2+switch_size.z-edge_bump_dist]) rotate([0,90,0]) cylinder(r=3/2,h=size.x);
    
    
       /* translate([size.x/2-width.x/2-switch_recess-METRIC_NUT_THICKNESS[3],-switch_size.y/2-width.y/2,0])
        { 
            #translate([width.x/2,width.y/2+5,width.z/2+switch_size.z-edge_bump_dist]) rotate([0,90,0]) nutHole(3);            
            #translate([width.x/2,switch_size.y+width.y/2-5,width.z/2+switch_size.z-edge_bump_dist]) rotate([0,90,0]) nutHole(3);
        
         
            
            
        }*/
    }
    
    /*
    translate([size.x/2-width.x/2-switch_recess,-switch_size.y/2-width.y/2,0])
    { 
      
        translate([width.x/2+switch_size.x,width.y/2+5,width.z/2+switch_size.z-edge_bump_dist]) sphere(r=2/2);            
       translate([width.x/2+switch_size.x,switch_size.y+width.y/2-5,width.z/2+switch_size.z-edge_bump_dist]) sphere(r=2/2);
        
        translate([width.x/2,width.y/2+5,width.z/2+switch_size.z-edge_bump_dist]) sphere(r=2/2);            
        translate([width.x/2,switch_size.y+width.y/2-5,width.z/2+switch_size.z-edge_bump_dist]) sphere(r=2/2);
    
     
        
        
    }*/
    
    
    
}