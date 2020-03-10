use <../english-brick-wall/wall.scad>;
use <right-wall.scad>;
use <back-wall.scad>;

right_wall(end = [false, false]);

translate([- clay_width() / 2 - clay_dent() - clay_depth(), 0, clay_width() / 2 + clay_dent() + clay_depth()])
rotate([0, 90, 0])
back_wall(bottom_long = false, end = [false, false]);
