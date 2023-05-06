// Variables

// The handle of the lawn mower is not perfect cylinder
// It is taller than it is wide. 21.4mm tall and 21 mm wide
// I use a circle that is slightly bigger for now. 
mowerHandleRadius   = 21.5 / 2;

screwWidth = 5;
screwHeadDiameter = 8;
screwHeadDepth = 3;
screwHeadHoleDepth = 2.2;

cylinderPoleWidth = 7.5;
cylinderPoleLength = 20.5; // Length of th connecting pole

cylinderLength = 40;

baseSquare = 28;
baseSquareWidth = baseSquare / 2;

rotate([90,0,90]) {
    linear_extrude(cylinderLength) {
        
        union() {
            difference() {
                translate([-(baseSquareWidth/2), 0, 0]) 
                square([baseSquareWidth, baseSquare], true);
                color("red") circle(mowerHandleRadius);
            }
        }
        
    }
}

jointWidth = 5; // The width of the joint part
jointSides = 10; // The length and height for the joint part

jointZPos = - (baseSquare/2);

jointYPos = -  (jointSides - jointWidth/2);

translate([cylinderLength, jointYPos, jointZPos])
    color("green") cube([jointSides,jointWidth,jointSides]);