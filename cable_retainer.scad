difference(){
difference() {
translate([0, 0, 2])
cube([40, 8, 5], center=true);

rotate([90,0,0])
translate([-12,0,0])
cylinder(h=10, d=4, $fn=50, center=true);

rotate([90,0,0])
translate([-5,0,0])
cylinder(h=10, d=4, $fn=50, center=true);

rotate([90,0,0])
translate([5,0,0])
cylinder(h=10, d=4, $fn=50, center=true);

rotate([90,0,0])
translate([12,0,0])
cylinder(h=10, d=4, $fn=50, center=true);
}

cylinder(h=20, d=3, center=true, $fn=20);
translate([-17,0,0])
cylinder(h=20, d=3, center=true, $fn=20);
translate([17,0,0])
cylinder(h=20, d=3, center=true, $fn=20);
}