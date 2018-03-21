module lamp() {
    color("lightgrey") {
        translate([0,0,55])
        cylinder(d=15, h=40, $fn=50);
        translate([0,0,55])
        cylinder(h=20, d1=40, d2=15);
        cylinder(d=40, h=55, $fn=100);
    }
    color("grey") {
        translate([0,0,-30])
        cylinder(h=30, d=35, $fn=100);
        translate([0,0,-70])
        cylinder(h=40, d2=35, d1=100, $fn=100);
    }
}

module frame() {
    color("lightgreen") {
        cube([22, 22, 200], center=true);
    }
}

union() {
translate([0,0,7.5])
difference() {
translate([3,3,0])
cube([25,25,25], center=true);
cube([22, 22, 50], center=true);

translate([0,0,6])
rotate([0,90,0])
cylinder(d=3, h=80, center=true, $fn=20);

translate([0,0,-6])
rotate([90,0,0])
cylinder(d=3, h=80, center=true, $fn=20);
}
difference() {
translate([29,29,0])
rotate([0,0,-45])
cube([10,50,10], center=true);

translate([60,60,10])
rotate([22,-22,0])
cylinder(d=48, h=20, center=true, $fn=100);
}

translate([0,0,12.3])
difference() {
translate([59,59,0])
rotate([22,-22,0])
cylinder(d=50, h=12, center=true, $fn=100);
translate([60,60,0])
rotate([22,-22,0])
cylinder(d=40, h=14, center=true, $fn=100);
// make a cut
translate([70,70,20])
rotate([0,0,45])
cube([50,20,50], center=true);
}
}

/*
frame();
translate([65,65,0])
rotate([22,-22,0])
lamp();
*/
