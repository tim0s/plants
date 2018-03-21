module hinge_bottom() {
    union(){
    translate([0,-2, 0])
    cylinder(d=4, h=38, $fn=30);

    difference() {
        translate([-24/2+2, 0,-40/2])
        cube([24, 8, 40], center=true);

        translate([-10-2, 0,-6])
        rotate([90,0,0])
        cylinder(d=3, h=10, center=true, $fn=20);

        translate([-10+2,0,-34])
        rotate([90,0,0])
        cylinder(d=3, h=10, center=true, $fn=20);
        
        translate([-12, -2, -6])
        rotate([90,0,0])
        cylinder(d=10, h=5, center=true, $fn=40);
        
        translate([-8, -2, -34])
        rotate([90,0,0])
        cylinder(d=10, h=5, center=true, $fn=40);
    }
}
}

module hinge_top() {
    union() {
        difference() {
            cylinder(d=10, h=42, $fn=50);
            translate([0,0,-0.2])
            cylinder(d=4.4, h=40, $fn=30);
        }

        difference() {
            translate([2.5,-4.5,0])
            cube([60, 9, 42]);
            translate([5, -1.5, -1])
            cube([60, 3, 44]);
            
            for (x=[10,50]) {
                for (y=[34,8]) {
                    translate([x,0,y])
                    rotate([90,0,0])
                    cylinder(d=2.4, h=10, center=true, $fn=20);
                }
            }
        }
    }
}
//translate([0,2,0])
hinge_bottom();
//hinge_top();