unit_width = 3;
unit_height = 1;

clay_width = 0.4;
clay_depth = 1;
clay_dent = 0.5; // へこみ

function brick_width(div = 1) = unit_width / div - clay_width;
brick_height = unit_height - clay_width;
brick_float = clay_dent + clay_depth  - brick_width(2);

module brick(div = 1) {
  color("brown")
  cube([brick_width(div), brick_height, brick_width(2)]);
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
  translate([clay_width / 2, clay_width / 2, brick_float])
  brick(div);

  if (!end[0]) { // 左端なし
    translate([clay_width / 2 + clay_dent, 0, 0]) clay(div, end);
  } else {
    clay(div, end);
  }
}

module line(width, long = true, end = [true, true]) {
  if (long) {
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
  } else {
    unit(div = 2, end = [end[0], true]);

    translate([unit_width / 2, 0, 0]) unit(div = 4);

    for (w = [0 : 2 * width - 4]) {
      translate([(1 / 2 + 1 / 4 + w / 2) * unit_width, 0, 0]) unit(div = 2);
    }

    translate([(1 / 2 + 1 / 4 + (2 * width - 3) / 2) * unit_width, 0, 0]) unit(div = 4);

    translate([(1 / 2 + 1 / 4 + (2 * width - 3) / 2 + 1 / 4) * unit_width, 0, 0]) unit(div = 2, end = [true, end[1]]);
  }
}

module wall(width, height, bottom_long = true, end = [true, true]) {
  for (h = [0 : height - 1]) {
    if (0 == h % 2) {
      translate([0, h * unit_height, 0]) line(width = width, long = bottom_long, end = end);
    } else {
      translate([0, h * unit_height, 0]) line(width = width, long = !bottom_long, end = end);
    }
  }
}

wall(10, 10);

function unit_width() = unit_width;

function unit_height() = unit_height;

function clay_width() = clay_width;

function clay_depth() = clay_depth;

function clay_dent() = clay_dent;
