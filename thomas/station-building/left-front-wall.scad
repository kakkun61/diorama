use <../english-brick-wall/wall.scad>;
use <left-wall.scad>;
use <front-wall.scad>;

left_wall(end = [false, false]);

translate([side_width() - clay_width() / 2 - clay_dent() - clay_depth(), platform_height(), clay_width() / 2 + clay_dent() + clay_depth()])
rotate([0, 90, 0])
front_wall(bottom_long = false, end = [false, false]);
