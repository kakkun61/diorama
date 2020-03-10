use <../english-brick-wall/wall.scad>;

width = 87;
height = 50;

module left_half() {
  polygon(
    points =
      [
        [12, 0],
        [10.5, 7],
        [10, 15],
        [11, 23],
        [15, 33],
        [20, 39],
        [30, 43],
        [38, 44.5],
        [45, 45],
        [45, 0]
      ]
  );
}

module tunnel() {
  translate([0, 0, -2])
  linear_extrude(5) {
    left_half();

    translate([45, 0, 0])
    mirror([1, 0, 0])
    translate([-45, 0, 0])
    left_half();
  }
}

difference() {
  wall(width / unit_width(), height / unit_height());

  tunnel();
}
