
difference() {
difference() {
cube([32,32,8], center=true);
translate([-8,-8,4])
cube([28,28,30], center=true);
}
translate([-5, -5, -1])
cube([28,28, 2.6], center=true);

translate([11.2,11.2,3]) {
    cylinder(d=7, h=4, $fn=20, center=true);
    cylinder(d=3, h=20, $fn=20, center=true);
}
}