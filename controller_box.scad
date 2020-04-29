include <openscad-boxmaker/boxmaker.scad>


//Inspiration : https://www.youtube.com/watch?v=kM9bWo8Rl84

L = 300;
W = 350;
H = 140;

T = 17;
t = 3.7;
slider_inset = 5;

inner = [W-2*T, L-2*T, H-2*T];

bottom();
top();
left();
right();
front();
back();

module bottom() {
    smps_bottom_t = T-10;
    difference() {
        _bottom();
        _right();
        translate([60,10,smps_bottom_t]) rotate([0,-90,0]) smps();
        translate([211+100,211,114+smps_bottom_t]) rotate([0,90,90]) smps();        
        
    }
}

module left() {
    difference() {
        _left();
        _top();
        //AC connector
        translate([-T,L-60-T,T+5]) rotate([0,0,90]) IEC13_panel_cutout();
        
    }
}

module front() {
    difference() {
        _front();
        _top();
        translate([70,-T,T+10]) cube([80,T,80]);
        translate([70+80+50,-T,T+10]) cube([80,T,80]);
    }
}

module back() {
    difference() {
        _back();        
        _top(); 
        //translate([0,L-T,T+5]) IEC13_panel_cutout();
      
    }
}

module top() {
    difference() {
        _top();
        //translate([25,L-55,H-41]) rotate([0,0,90]) import("estop.stl");
        translate([25,L-55,H-41]) rotate([0,0,90]) cylinder(r=21.6/2,h=100);
        #translate([-T/2+70+80,-T/2+80,H-t-slider_inset])  cube([80,80,t]);
        
    }
}

module right() {
    n_stepper = 4;
    stepper_labels = ["X M", "YR M", "YL M", "Z M"];
    
    _stepper_r = 17.75/2;
    _stepper_padding = 40;
    _stepper_start = (L - ((n_stepper-1)*_stepper_padding + n_stepper*2*_stepper_r))/2;
    
    n_row2 = 4;
    row2_labels = ["XZ ES", "Y ES", "         Spindle", ""];

    _stepper_padding = 40;
    _row2_start = (L - ((n_row2-1)*_stepper_padding + n_stepper*2*_stepper_r))/2;
    
    difference()
    {
        _right();
        // Stepper
       translate([W-T-slider_inset,-T/2,T/2]) for(i = [0:n_stepper-1])
       {
            translate([0,_stepper_start + i*_stepper_padding + i*2*_stepper_r,100]) rotate([0,-90,0]) cylinder(r=_stepper_r,h=2*t);
            translate([-t/2,_stepper_start + i*_stepper_padding + i*2*_stepper_r, 100-2*_stepper_r])  rotate([90,0,90]) linear_extrude(t/2) text(stepper_labels[i], size=_stepper_r, halign="center", valign="center");
        }
        //Others
        translate([W-T-slider_inset,-T/2,T/2]) for(i = [0:n_row2-1])
       {
           if(i == n_row2-1)
               translate([0,_row2_start + i*_stepper_padding + i*2*_stepper_r-_stepper_padding/1.5,50]) rotate([0,-90,0]) cylinder(r=5.9/2,h=2*t);
           else
                translate([0,_row2_start + i*_stepper_padding + i*2*_stepper_r,50]) rotate([0,-90,0]) cylinder(r=_stepper_r,h=2*t);
            translate([-t/2,_row2_start + i*_stepper_padding + i*2*_stepper_r, 50-2*_stepper_r])  rotate([90,0,90]) linear_extrude(t/2) text(row2_labels[i], size=_stepper_r, halign="center", valign="center");
        }
    }
}

module _top() {
    difference() {
        translate([-T/2,-T/2,H-t-slider_inset]) cube([W-T/2,L-T,t]);      
    }
}

module _bottom() {
    linear_extrude(T) side_a(inner,T,[50,50,50,50],[1,-1,1,1]);
}

module _left() {
    translate([-T,0,T]) rotate([90,0,90]) linear_extrude(T) side_b(inner,T,[50,50,50,50]);
}

module _right() {
    translate([W-T-slider_inset-t,-T/2,T/2]) cube([t,L-T,H-slider_inset-T/2-t-0.2]);
}

module _front() {
    translate([0,0,T]) rotate([90,0,0]) linear_extrude(T) side_c(inner,T,[50,50,50,50],[0,0,1,1]);
}

module _back() {
    translate([0,inner.y+T,T]) rotate([90,0,0]) linear_extrude(T) side_c(inner,T,[50,50,50,50],[0,0,1,1]);
}


module rough_placement() {
    H = 114 + 2*1.8 + 20;
    echo(H);
    #translate([-70,0,0]) cube([350,300,H+30]);
    rotate([0,-90,0]) smps();
    translate([211+50,211+10,114]) rotate([0,90,90]) smps();
    translate([60,211,0]) rotate([0,0,-90]) tb6560();
    translate([120,211,0]) rotate([0,0,-90]) tb6560();
    translate([180,211,0]) rotate([0,0,-90]) tb6560();
    translate([200,211-40,0]) cube([50,40,65]);

    translate([20,10,0]) uno();
    translate([120,10,0]) spindle_controller();

    translate([0,250,-50+130]) color("red") cylinder(r=30, h=70);
}


module smps() {
    color("grey") cube([114,211,50]);
}

module tb6560() {
    translate([50,+12.5,0]) import("TB6560_holder/files/TB6560_2.stl");
}

module uno() {
    color("blue") cube([75,75,40]);
}

module spindle_controller() {
    color("blue") cube([75,75,40]);
}

module IEC13_panel_cutout() {
    r = 3;
    s = [27.2-r,19.2-r,25];
    translate([20,0,s.y/2+r]) rotate([90,0,0]) union()
    {
        linear_extrude(s.z)
        hull()
        {
            translate([s.x/2,s.y/2,0]) circle(r=r);
            translate([s.x/2,-s.y/2,0]) circle(r=r);
            translate([-s.x/2,s.y/2,0]) circle(r=r);
            translate([-s.x/2,-s.y/2,0]) circle(r=r);
        }
        translate([20,0,0]) cylinder(r=3.5/2, h = s.z);
        translate([-20,0,0]) cylinder(r=3.5/2, h = s.z);
        
    }
}



/*
function getNotch(pt,isX,notch_l, notch_w) = isX ? [ [pt.X,pt.Y], [pt.X+notch_w,pt.Y], [pt.X+notch_w,pt.Y+notch_l], [pt.X,pt.Y+notch_l] ] : [ [pt.X,pt.Y], [pt.X,pt.Y+notch_w], [pt.X+notch_l,pt.Y+notch_w], [pt.X+notch_l,pt.Y] ];

function flatten(l) = [ for (a = l) for (b = a) b ] ;

module getSide(L,W,tab_l)
{
    tab_l > 0 ? _getSide(L,W,tab_l) : _getSide();
    
}

module _getSide(L, W, tab_l)
{
    polygon( [
        [0,0],

        [0,W/3],
        [tab_l,W/3],
        [tab_l,2*W/3],
        [0,2*W/3],

        [0,W],

        [L/3,W],
        [L/3,W-tab_l],
        [2*L/3,W-tab_l],
        [2*L/3,W],

        [L,W],

        [L,2*W/3],
        [L-tab_l,2*W/3],
        [L-tab_l,W/3],
        [L,W/3],

        [L,0],

        [2*L/3,0],
        [2*L/3,tab_l],
        [L/3,tab_l],
        [L/3,0],
    ] );
}
*/
