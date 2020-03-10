use <constant.scad>;
use <../english-brick-wall/wall.scad>;

window_width = 8;
window_height = 10;

door_width = 12;
door_height = 20;

name_plate_width = 32;
name_plate_height = 5;

module window_hole(h = 10, z = -5) {
  translate([0, 0, z]) {
    translate([window_width / 2, window_height - window_width / 2, 0])
    cylinder(r = window_width / 2, h = h);

    cube([window_width, window_height - window_width / 2, h]);
  }
}

module window_flame() {
  color("green")
  difference() {
    window_hole(h = clay_depth() - 0.5, z = 0);

    translate([0, 0, -5]) {
      thickness = 0.8;
      translate([window_width / 2, window_height - window_width / 2, 0])
      cylinder(r = window_width / 2 - thickness, h = 10);

      translate([thickness, 0, 0])
      cube([window_width - 2 * thickness, window_height - window_width / 2, 10]);
    }
  }
}

module window_table() {
  thickness = 1;
  color("green")
  cube([window_width, thickness, clay_dent() + clay_depth() + 0.5]);
}

module window(positions) {
  difference() {
    children(0);

    for (p = positions) {
      translate([p, 10, 0])
      window_hole();
    }
  }

  for (p = positions) {
    translate([p, 10, 0])
    window_flame();

    translate([p, 10, 0])
    window_table();
  }
}

module door_hole() {
  translate([0, 0, -5]) {
    cube([door_width, door_height, 10]);
  }
}

module door_plate() {
  color("green")
  cube([door_width, door_height, clay_dent() + clay_depth() - 0.7]);
}

module door_window_hole() {
  thickness = 1.5;
  translate([thickness, 10, -5])
  cube([12 - 2 * thickness, 10 - thickness, 10]);
}

module door(positions) {
  difference() {
    children(0);

    for (p = positions) {
      translate([p, 0, 0])
      door_hole();
    }
  }

  for (p = positions) {
    translate([p, 0, 0])
    difference() {
      door_plate();

      door_window_hole();
    }
  }
}

module name_plate() {
  thickness = 0.5;
  difference() {
    color("yellow")
    cube([name_plate_width, name_plate_height, clay_dent() + clay_depth() + 0.2]);

    translate([thickness, thickness, clay_dent() + clay_depth()])
    cube([name_plate_width - 2 * thickness, name_plate_height - 2 * thickness, 1]);
  }
}

module front_wall(bottom_long = true, end = [true, true]) {
  door([32, 97]) {
    window([12, 56, 77, 121]) {
      wall(front_width() / unit_width(), front_height(), bottom_long = bottom_long, end = end);
    }
  }

  translate([(front_width() - name_plate_width) / 2, 24, 0])
  name_plate();
}

front_wall();
