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
        //translate([cylinderLength - jointPartWidth,0,0])
        // Move the part to the outer edge 
        //translate([0,-(baseSquareWidth - jointPartWidth), 0])
        // Move the part to the bottom
        //translate([0,0,-baseSquareWidth])
        //color("green") 
        jointPart(partWidth = 10, thicknes = jointPartWidth);
    
    
}

module mountPart(isLeft = true) {
    
    difference() {
        cube([cylinderLength ,baseSquareWidth, baseSquare]);
        
        translate([0,baseSquareWidth,baseSquareWidth]) 
        rotate([0,90,0])
        //color ("red") 
        cylinder(h = cylinderLength, r = mowerHandleRadius);
    }
}

// The JointPart is the part that joins the mount part witht the handle part
module jointPart(partWidth = 10, thicknes = 1, location = "left") {
    rotate([-90,0,0])
    linear_extrude(height = thicknes)  
    hull() {
        square(size = partWidth, center = false);
        translate([partWidth / 2, partWidth, 0]) circle(r = partWidth / 2);
    }
}

mainPart();
//mountPart();
//jointPart(partWidth = 10, thicknes = jointPartWidth);

//color("blue") jointPart(partWidth = 10, thicknes = 2);