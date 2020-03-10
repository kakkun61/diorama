use <left-wall.scad>;

module right_wall(end = [true, true]) {
    mirror([1, 0, 0]) left_wall(end = end);
}

right_wall();
