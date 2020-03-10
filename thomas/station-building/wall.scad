block_thickness = 0.6; // unit_width が 2.5 になるよう逆算
clay_width = 13 / 30;  // unit_width が 2.5 になるよう逆算
clay_thickness = block_thickness - 0.5;

block_width = 2 * block_thickness + 2 * clay_width;

unit_width = block_width + clay_width;
unit_height = 1;

block_height = unit_height - clay_width;

module block() {
    color("brown")
    cube([block_width, block_height, block_thickness]);
}

module clay(right_end_clay = true) {
    color("grey")
    cube([unit_width - (right_end_clay ? 0 : block_thickness - clay_thickness), unit_height, clay_thickness]);
}

module unit(right_end_clay = true) {
    translate([clay_width / 2, clay_width / 2, 0])
    block();

    clay(right_end_clay);
}

module block_half() {
    color("brown")
    cube([block_width / 2, block_height, block_thickness]);
}

module clay_half(right_end_clay = true) {
    color("grey")
    cube([unit_width / 2 - (right_end_clay ? 0 : block_thickness - clay_thickness), unit_height, clay_thickness]);
}

module unit_half(right_end_clay = true) {
    translate([clay_width / 2, clay_width / 2, 0])
    block_half();

    clay_half(right_end_clay);
}

module wall(width, height, right_end_clay = true) {
    for (w = [0 : width - 1], h = [0 : height - 1]) {
        if (0 == h % 2) {
            translate([w * unit_width, h * unit_height, 0]) {
                if (w == width - 1) {
                    unit(right_end_clay);
                } else {
                    unit();
                }
            }
        } else {
            translate([0, h * unit_height, 0]) {
                if (w == 0) {
                    translate([unit_width / 2, unit_height, 0])
                    rotate([0, 0, 180])
                    unit_half();
                } else {
                    translate([(w - 0.5) * unit_width, 0, 0])
                    unit();
                }
                if (w == width - 1) {
                    translate([(w + 0.5) * unit_width, 0, 0])
                    unit_half(right_end_clay);
                }
            }
        }
    }
}

function unit_width() = unit_width;

function front_width() = 140;

function front_height() = 35;

function platform_height() = 16;

function back_height() = front_height() + platform_height();

function side_width() = 45;

function clay_thickness() = clay_thickness;

function block_thickness() = block_thickness;

wall(10, 10);
