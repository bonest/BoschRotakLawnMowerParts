// Variables

// The handle of the lawn mower is not perfect cylinder
// It is taller than it is wide. 21.4mm tall and 21 mm wide
// I use a circle that is slightly bigger for now. 
mowerHandleRadius   = 21.5 / 2;

// Size of the main base
baseMountLength = 40;
baseMountWidth = 28;
baseMountPartWidth = baseMountWidth / 2;

screwWidth = 5;
screwHeadDiameter = 8;
screwHeadDepth = 3;
screwHeadHoleDepth = 2.2;

cylinderPoleWidth = 7.5;
cylinderPoleLength = baseMountPartWidth; //Length of th connecting pole

jointPartWidth = baseMountWidth / 3;

// TODO: Male = the left part
// TODO: screw / bolt cutout on base part
// TODO: Screw / bold cutout on hinge


// combines basepart and hinge part to the main part. 
module mainPart(isMale = true)
{        
        union() 
        {
        // The outer base part
        mountBasePart(isLeft = isLeft);
        

        // The hinge part
        hingePart(partWidth = 10, thicknes = jointPartWidth);

        }

        

    
}

// Returns the main base part without the hinge
module mountBasePart(isMale = true) {
    
    if (isMale)
    {

        mountBase(isMale);

        // Bar rim (sticking out)
        mountRims();
    }
    else {  
        difference() {
            mountBase(isMale);
            // The bar rim cutout on the right part. 
            mountRims(isCutOut = true);
        }
        
    }
    
}

// Creates the base part with the joining pole
module mountBase(isMale = true) 
{
    difference() {
        // Outer cube
        cube([baseMountLength ,baseMountPartWidth, baseMountWidth]);
        
        // Inner cylinder cutout
        translate([0,baseMountPartWidth,baseMountPartWidth]) 
        rotate([0,90,0])
        cylinder(h =baseMountLength, r = mowerHandleRadius);
    }

    // Inner handle pole
    translate( [baseMountLength / 2, 0, baseMountWidth / 2] ) 
    rotate([-90,0,0]) handlePole();    

    // Add the screw cutout
    if (isMale)
    {

    }
}

module mountRims(isCutOut = false)
{
    rimJoinPadding = isCutOut ? 4 : 6;
    rimJoinLength = baseMountLength - rimJoinPadding;

    rimJoinDepth  = 2;

    rimJoinPos_X = (baseMountLength - rimJoinLength) / 2;
    rimJoinPos_Y = (baseMountWidth - rimJoinDepth) / 2;
    rimJoinPos_Z = (baseMountPartWidth - (mowerHandleRadius*2)) / 4;

    // lover rim
    
    translate([rimJoinPos_X, rimJoinPos_Y,-rimJoinPos_Z]) mountRimJoiner(length = rimJoinLength, depth = rimJoinDepth);
    // upuper rim 
    translate([rimJoinPos_X, rimJoinPos_Y,baseMountWidth + rimJoinPos_Z + 0.25]) mountRimJoiner(length = rimJoinLength, depth = rimJoinDepth);
}

// small cylinders that can be either added or cutout or added to the base rim 
module mountRimJoiner(length = 10, depth = 4, thicknes = 2)
{
    rotate([0,90,0]) 
    hull()
    {
        cylinder(h = length, r = thicknes / 2);
    
        translate([0,depth,0]) cylinder(h = length, r = thicknes / 2);
    }
   


}

// The  hinge Part is the part that joins the mount part witht the handle part
module hingePart(partWidth = 10, thicknes = 1, location = "left") {
    rotate([-90,0,0])
    linear_extrude(height = thicknes)  
    hull() {
        square(size = partWidth, center = false);
        translate([partWidth / 2, partWidth, 0]) circle(r = partWidth / 2);
    }
}

// The HandlePole is the pole that goes through the lawnmowers handle.
module handlePole(screwThicknes = 4.9)
{
    difference() 
    {
        // Outer Cylinder
        cylinder(h = baseMountPartWidth, r = cylinderPoleWidth / 2);

        // Inner Cylinder
        cylinder(h = baseMountPartWidth, r = screwThicknes / 2 );
    }
    
}

partPadding = 10;
// Create the right part of the base
//translate([0,baseMountWidth + partPadding,0]) mirror([0,1,0]) mainPart(isLeft = false);

//color("green") 
mainPart(isMale = false);