use <constant.scad>;
use <../english-brick-wall/wall.scad>;

module left_wall(end = [true, true]) {
  translate([0, platform_height(), 0])
  wall(side_width() / unit_width(), front_height(), end = end);

  wall(side_width() / unit_width() - 1, front_height(), end = end);
}

left_wall();
