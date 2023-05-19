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

jointPartWidth = baseSquare / 3;
//jointTranslate = (baseSquareWidth / 2) - jointPartWidth;

module mainPart(isLeft = true)
{
    mountPart(isLeft = isLeft);

    // Move the part to its posisiton
    translate([cylinderLength - jointPartWidth - 1,0,0])
    // Move the part to the outer edge 
    translate([0,-(baseSquareWidth - jointPartWidth), 0])
    // Move the part to the bottom
    translate([0,0,-baseSquareWidth])
    color("green") jointPart(partWidth = 10, thicknes = jointPartWidth);
}

module mountPart(isLeft = true) {
    //rotate([90,0,90]) {
        //linear_extrude(cylinderLength) {
            
            union() {
                difference() {
                    translate([-(baseSquareWidth/2), 0, 0]) 
                    square([baseSquareWidth, baseSquare], true);
                    color("red") circle(mowerHandleRadius);
                }
            }
            
       //}
    //}
}

// The JointPart is the part that joins the mount part witht the handle part
module jointPart(partWidth = 10, thicknes = 0, location = "left") {
    // moving it to 0,0,0 in the reight orientation
    translate([partWidth / 2, 0,0]) 
    rotate([90,90,0])
    
    linear_extrude(height = thicknes) {
        
        union() {
            // the base square
            translate([partWidth / 4, 0,0])
            square([partWidth / 2, partWidth], center = true);   
        
        
            // the half orb
            translate([partWidth / 2, 0, 0]) {
                intersection() {
                    circle(d = partWidth);
                    translate([partWidth / 2, 0, 0]) square(partWidth, center = true);
                }
            }
        }
    } 
}

//mainPart();
mountPart();

//color("blue") jointPart(partWidth = 10, thicknes = 2);