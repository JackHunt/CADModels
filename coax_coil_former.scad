$diameter = 38.1;
$num_turns = 8;
$coax_diameter = 6;

module coax_trap_former()
{    
    $height = ($num_turns + 1) * $coax_diameter;
    $wall_thickness = $diameter / 8;

    $radius = $diameter / 2;
    $inner_radius = $radius - $wall_thickness;
    
    module coax_hole()
    {
        $coax_radius = $coax_diameter / 2;
        rotate([0, 90, 0])
        cylinder(1.1 * $diameter, $coax_radius, $coax_radius, false, 
                 $fa = 0.5, $fs = 0.5);
    }
    
    difference()
    {
        cylinder($height, $radius, $radius, false, 
                 $fa = 0.5, $fs = 0.5);
    
        cylinder($height * 2.1, $inner_radius, $inner_radius, 
                 true, $fa = 0.5, $fs = 0.5);
        
        translate([0, 0, $coax_diameter])
        coax_hole();
        
        translate([0, 0, $height - $coax_diameter])
        coax_hole();
    }
}

coax_trap_former();