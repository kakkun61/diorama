use <../english-brick-wall/wall.scad>;

left_width = 45;
right_width = 60;
width = left_width + right_width;
upper_height = 55;
lower_height = 15;

module tunnel() {
  translate([0, 0, -2])
  linear_extrude(5)
  polygon(
    points =
      [
        [11.5, 0],
        [11.5, lower_height],
        [10.5, 20],
        [10, 30],
        [11, 38],
        [15, 48],
        [20, 54],
        [30, 58],
        [40, 60],
        [50, 60],
        [60, 58],
        [70, 54],
        [77, 47],
        [80, 40],
        [81.5, 33],
        [82, 25],
        [81.5, 15],
        [80, 7],
        [78.5, 0]
      ]
  );
  
}

difference() {
  union() {
    translate([0, lower_height, 0])
    wall(width / unit_width(), upper_height / unit_height());

    translate([left_width, 0, 0])
    wall(right_width / unit_width(), lower_height / unit_height(), bottom_long = false);
  }

  tunnel();
}
