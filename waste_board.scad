include <MCAD/nuts_and_bolts.scad>

difference() {
    //sheet
    union() {
        //cube([400,600,17]);
        translate([50,0,0]) cube([300,500,17]);
    }
    
    for( i = [50,50+250,50+250*2] )
        {
            color("black") translate([10,i,17]) rotate([0,180,0]) boltHole(5,MM,40);
            color("black") translate([400-10,i,17]) rotate([0,180,0]) boltHole(5,MM,40);
        }
        
    translate([50,0,15]) cube([300,500,2]);
    translate([50,0,0]) {   
        //insets M4?
        for( i = [  10/2 + 2 : 45 : 300] )
            for( j = [  10/2 + 2 : 45 : 500] )
                #translate([i,j,0]) cylinder(r=10/2,h=3);
    }
    translate([50,0,3]) {   
        //insets M4?
        for( i = [  10/2 + 2 : 45 : 300] )
            for( j = [  10/2 + 2 : 45 : 500] )
                #translate([i,j,0]) cylinder(r=5/2,h=15-3);
    }
}
