use <constant.scad>;

unit_width = 3;
unit_height = 1.5;

clay_width = 0.4;
clay_depth = 1;
clay_dent = 0.5; // へこみ

function slate_width(div = 1) = unit_width / div - clay_width;
slate_height = unit_height;
slate_float = clay_dent + clay_depth  - slate_width(2);
slate_angle = atan(clay_dent / slate_height);

roof_height = side_width() / 2 + eave_width();
front_roof_width = front_width() + 2 * eave_width();
side_roof_width = side_width() + 2 * eave_width();

module slate(div = 1) {
  center_y = slate_height / 2;
  center_z = - slate_width(2) / 2;

  color("dimgrey")
  translate([0, 0, slate_width(2)])
  translate([0, center_y * cos(slate_angle) - center_z * sin(slate_angle) - center_y, 0]) // Y 軸方向の中心を維持する
  rotate([- slate_angle, 0, 0])
  translate([0, 0, - slate_width(2)]) // 回転の中心を上端に
  cube([slate_width(div), slate_height, slate_width(2)]);
}

module clay(div = 1, end = [true, true]) {
  color("white") {
    if (end[0] && end[1]) { // 両端あり
      cube([unit_width / div, unit_height, clay_depth]);
    } else if (end[0] || end[1]) { // 片端のみ
      cube([unit_width / div - clay_width / 2 - clay_dent, unit_height, clay_depth]);
    } else { // 両端なし
      cube([unit_width / div - clay_width - 2 * clay_dent, unit_height, clay_depth]);
    }
  }
}

module unit(div = 1, end = [true, true]) {
  translate([clay_width / 2, clay_width / 2, slate_float])
  slate(div);

  if (!end[0]) { // 左端なし
    translate([clay_width / 2 + clay_dent, 0, 0]) clay(div, end);
  } else {
    clay(div, end);
  }
}

module line(width, shift = true, end = [true, true]) {
  if (shift) {
    unit(div = 2, end = [end[0], true]);

    for (w = [0 : width - 2]) {
      translate([(1 / 2 + w) * unit_width, 0, 0]) unit();
    }

    translate([(1 / 2 + 1 / 4 + (2 * width - 3) / 2 + 1 / 4) * unit_width, 0, 0]) unit(div = 2, end = [true, end[1]]);
  } else {
    for (w = [0 : width - 1]) {
      translate([w * unit_width, 0, 0]) {
        if (w == 0) {
          unit(end = [end[0], true]);
        } else if (w == width - 1) {
          unit(end = [true, end[1]]);
        } else {
          unit();
        }
      }
    }
  }
}

module plate(width, height, bottom_shift = true, end = [true, true]) {
  for (h = [0 : height - 1]) {
    if (0 == h % 2) {
      translate([0, h * unit_height, 0]) line(width = width, shift = bottom_shift, end = end);
    } else {
      translate([0, h * unit_height, 0]) line(width = width, shift = !bottom_shift, end = end);
    }
  }
}

module shape() {
  color("dimgrey")
  intersection() {
    rotate([90, 0, 0])
    linear_extrude(side_roof_width)
    polygon([[0, 0], [front_roof_width, 0], [front_roof_width - roof_height, roof_height], [roof_height, roof_height]]);

    translate([0, - side_roof_width, 0])
    rotate([90, 0, 90])
    linear_extrude(front_roof_width)
    polygon([[0, 0], [side_roof_width, 0], [side_roof_width - roof_height, roof_height], [roof_height, roof_height]]);
  }
}

module roof() {
  intersection() {
    shape();

    translate([0, - side_roof_width, 0])
    rotate([45, 0, 0])
    translate([0, 0, - clay_dent - clay_depth])
    plate(front_roof_width / unit_width, roof_height * sqrt(2) / unit_height);
  }

  intersection() {
    shape();

    translate([front_roof_width, 0, 0])
    rotate([0, 0, 180])
    rotate([45, 0, 0])
    translate([0, 0, - clay_dent - clay_depth])
    plate(front_roof_width / unit_width, roof_height * sqrt(2) / unit_height);
  }

  intersection() {
    shape();

    rotate([0, 0, -90])
    rotate([45, 0, 0])
    translate([0, 0, - clay_dent - clay_depth])
    plate(side_roof_width / unit_width, roof_height * sqrt(2) / unit_height);
  }

  intersection() {
    shape();

    translate([front_roof_width, - side_roof_width, 0])
    rotate([0, 0, 90])
    rotate([45, 0, 0])
    translate([0, 0, - clay_dent - clay_depth])
    plate(side_roof_width / unit_width, roof_height * sqrt(2) / unit_height);
  }
}

roof();
