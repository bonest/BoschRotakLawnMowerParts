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

// Todo: This will break if position of the base part is changed
// jointWidth is the thicknes of the joint part
// jointSides is the length of the joint part sides its a cube basically
module jointPart(jointWidth = 5, jointSides = 10) {

jointXPos = cylinderLength - jointSides;
jointZPos = - (baseSquare/2) - jointSides;

jointYPos = -  (jointSides - jointWidth/2);

translate([jointXPos, jointYPos, jointZPos])
    color("green") cube([jointSides,jointWidth,jointSides]);
}

jointPart();