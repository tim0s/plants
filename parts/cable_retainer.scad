width = 12;
length = 70;
height = 8;
cable_diameter = 5.2;
hole_diameter = 3;
cable_positions = [-23, -15, -7, 7, 15, 23];


difference(){
difference() {
translate([0, 0, 2])
cube([length, width, height], center=true);

rotate([90,0,0]) {
for (p=cable_positions) {
    translate([p,0,0]) {
        cylinder(h=width*2, d=cable_diameter, $fn=20, center=true);
        translate([0,-cable_diameter/2,0])
        cube([cable_diameter, cable_diameter, width*2], center=true);
    }
}
}
}

hole_offset = length/2 - hole_diameter/2 - 3.4;
for (i = [-1:1]) {
    translate([i*hole_offset,0,0]) {
        translate([0, 0, 4.5])
        cylinder(h=4.5, d=7, center=true, $fn=20);
        cylinder(h=height*2, d=hole_diameter, center=true, $fn=10);
    }
}
}