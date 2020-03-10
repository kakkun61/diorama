use <constant.scad>;
use <../english-brick-wall/wall.scad>;
use <front-wall.scad>;
use <back-wall.scad>;
use <right-wall.scad>;
use <left-wall.scad>;
use <roof.scad>;

rotate([90, 0, 270])
{
  translate([0, 0, - clay_width() / 2 - clay_dent() - clay_depth()])
  left_wall(end = [false, false]);

  translate([side_width() - clay_width() / 2 - clay_dent() - clay_depth(), platform_height(), 0])
  rotate([0, 90, 0])
  front_wall(bottom_long = false, end = [false, false]);

  translate ([0, 0, - front_width()])
  rotate([0, 180, 0]) {
    translate([0, 0, - clay_width() / 2 - clay_dent() - clay_depth()])
    right_wall(end = [false, false]);

    translate([- clay_width() / 2 - clay_dent() - clay_depth(), 0, 0])
    rotate([0, 90, 0])
    back_wall(bottom_long = false, end = [false, false]);
  }
}

translate([- eave_width(), eave_width(), back_height()])
roof();
