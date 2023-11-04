// Global params.
box_width = 250;
box_depth = 150;
box_height = 50;
lid_height = box_height / 10;
wall_thickness = 4;
screw_diameter = 4;
screw_head_diameter = 8;
screw_head_height = 2;
corner_padding = 10;

// Screw coords.
post_x_coords = [
    2 * wall_thickness,
    box_width / 2 - 0.5 * corner_padding,
    box_width - corner_padding
];
    
post_y_coords = [
    2 * wall_thickness,
    box_depth - corner_padding
];

// Function to create the hollow box with corner posts for screws
module main_box() {
    // Box.
    difference() {
        cube([box_width, box_depth, box_height]);

        // Hollow it out.
        translate([
            wall_thickness,
            wall_thickness,
            wall_thickness
        ])
        
        cube([
            box_width - 2 * wall_thickness,
            box_depth - 2 * wall_thickness,
            box_height - wall_thickness,
        ]);
    }
    
    for (x = post_x_coords) {
        for (y = post_y_coords) {
            translate([
                x - screw_diameter / 2,
                y - screw_diameter / 2,
                -wall_thickness
            ])
            
            cube([corner_padding, corner_padding, box_height]);
        }
    }
}

module sockets() {
    //
}

module box() {
    difference() {
        main_box();
        sockets();
    }
}

// Lid/faceplate.
module main_lid() {
    difference() {
        // Lid shape
        cube([box_width, box_depth, lid_height]);

        // Holes for the screws in the lid
        for (x = post_x_coords) {
            for (y = post_y_coords) {
                translate([
                    x - screw_diameter / 2,
                    y - screw_diameter / 2, 0
                ])
                
                cylinder(h = lid_height + 1,
                         d = screw_diameter,
                         $fn = 32);
            }
        }
    }
}

module faceplate_arrangement() {
    //
}

module lid() {
    difference() {
        main_lid();
        faceplate_arrangement();
    }
}

module main() {
    translate([100, 300, lid_height])
    box();
    lid();
}

main();