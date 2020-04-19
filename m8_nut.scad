include <MCAD/nuts_and_bolts.scad>

difference()
{
    cylinder(h=METRIC_NUT_THICKNESS[8],r=METRIC_NUT_AC_WIDTHS[8]);
    #nutHole(8,MM);
}