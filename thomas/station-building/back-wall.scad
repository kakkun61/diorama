use <constant.scad>;
use <../english-brick-wall/wall.scad>;

module back_wall(bottom_long = true, end = [true, true]) {
  wall(front_width() / unit_width(), back_height(), bottom_long = bottom_long, end = end);
}

back_wall();
