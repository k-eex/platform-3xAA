

module torus(d1,d2){
	rotate_extrude(convexity=10,$fn=64)
		translate([d1/2,0,0]) circle(d=d2,$fn=32);
}

module AA_space(){
	scale(1.01)
	translate([0,0,0])
		cylinder(h=50.5, d=14.5, $fn=64, center=true);
}

module AA_battery(){
	color("lightgray")
	translate([0,0,-0.65])
	union(){
		cylinder(h=49.2, d=14.5, $fn=64, center=true);
		translate([0,0,49.2/2])
			cylinder(h=1.3*2, d=5.5, $fn=32, center=true);
	}
}

module triple_AA_battery(){
	translate([-7.25,7.25,0])
		AA_battery();
	translate([7.25,7.25,0])
		AA_battery();
	translate([0,19.8,0])
		AA_battery();
}

module triple_AA_space(){
	translate([-7.25,7.25,0])
		AA_space();
	translate([7.25,7.25,0])
		AA_space();
	translate([0,19.8,0])
		AA_space();
}


module end_wall(){
	rotate([90,0,90])
	translate([0,0,0.5])
	difference(){
		hull(){
			translate([-7.25,7.25,0])
				cylinder(h=4, d=10, $fn=32,center=true);
			translate([0,19.8,0])
				cylinder(h=4, d=10, $fn=32,center=true);
			translate([7.25,7.25,0])
				cylinder(h=4, d=10, $fn=32,center=true);
			translate([0,1,0])
				cube([29,5,4],center=true);
		}
		translate([0,26.3,0]) cube([15,5,5],center=true);
	}
}

module end(){
	union(){
		difference(){
			end_wall();
			translate([-1.5,7.25/2,13.5]) rotate([30,0,0]) scale([1,2,1]) union() {
				cylinder(h=13, d=.75, $fn=16, center=true);
				translate([0,0,13/2+1.5/2]) rotate([90,0,0]) torus(d1=1.95,d2=.75);
				translate([0,0,-13/2-1.5/2]) rotate([90,0,0]) torus(d1=1.95,d2=.75);
			}
			translate([-1.5,-7.25/2,13.5]) rotate([-30,0,0]) scale([1,2,1]) 
				translate([0,0,-13/2-1.5/2]) rotate([90,0,0]) torus(d1=1.95, d2=.75);
		}
		intersection(){
			translate([2.5,0,19]) scale([0.4,1,1]) rotate([90,0,0]) cylinder(h=17, d=5, $fn=16, center=true);
			scale([3,1,1]) end_wall();
		}
	}
}

module espace(){
	union(){
		cube([4,16,8],center=true);
		translate([2,0,-0.7]) scale([0.45,1,1]) rotate([90,0,0]) cylinder(h=16, d=5, $fn=16, center=true);
	}
}

module base(){
	difference(){
		translate([0,0,1]) cube([50.5+6,29,5],center=true);
		rotate([90,0,90]) triple_AA_space();
	}
	translate([-56.5/2+3/2,0,0]) rotate([0,0,180]) end();
	translate([+56.5/2-3/2,0,0]) end();
}

//rotate([90,0,90]) triple_AA_battery();

module cap(){
	difference(){
		translate([0,0,22]) cube([63,15,10],center=true);
		rotate([90,0,90]) triple_AA_space();
		//translate([-56.5/2+2/2,0,0]) scale(1.02) rotate([0,0,180]) end();
		//translate([+56.5/2-2/2,0,0]) scale(1.02) end();
		translate([-56.5/2+2/2,0,20]) scale(1.02) rotate([0,0,180]) espace();
		translate([+56.5/2-2/2,0,20]) scale(1.02) rotate([0,0,000]) espace();
	}
}

base();
//cap();

translate([0,30,56.5/2-2.75]) rotate([180,0,0]) cap();


/*
rotate([90,0,0]) 
	difference(){
		translate([7,16,-6]) cube([15,9.5,50.5+12]);
		translate([0,0,-3]) end();
		translate([0,0,50.5]) translate([29,0,3]) rotate([0,180,0]) end();
		translate([0,0,-0.01]) scale(1.01) triple_AA_space();
	}
*/