$fn = 50;

base_height = 13;
base_radius = 9;

pillar_height = 24;
pillar_radius = 6;

tank_height = 17;
tank_radius = 12;

roof_height = 2;

cylinder(r = base_radius, h = base_height);

translate([0, 0, base_height])
cylinder(r = pillar_radius, h = pillar_height);

translate([0, 0, base_height + pillar_height])
cylinder(r = tank_radius, h = tank_height);

translate([0, 0, base_height + pillar_height + tank_height])
rotate_extrude()
polygon([[0, 0], [0, roof_height], [tank_radius, 0]]);

tube_radius = 1.5;
tube_length_1 = 10;
tube_length_2 = 3;
tube_curve_radius_3 = 2.5;

// translate([pillar_radius + 2, 0, base_height + pillar_height - tube_length_1]) {
//     cylinder(r = tube_radius, h = tube_length_1);

//     rotate([270, 0, 0])
//     translate([tube_radius, 0, 0])
//     rotate_extrude(angle = 180)
//     translate([tube_radius, 0, 0])
//     circle(r = tube_radius);

//     translate([2 * tube_radius, 0, 0])
//     cylinder(r = tube_radius, h = tube_length_2);

//     translate([2 * tube_radius, 0, tube_length_2])
//     rotate([90, 0, 180])
//     translate([- tube_curve_radius_3, 0, 0])
//     rotate_extrude(angle = 90)
//     translate([tube_curve_radius_3, 0, 0])
//     circle(r = tube_radius);
// }
