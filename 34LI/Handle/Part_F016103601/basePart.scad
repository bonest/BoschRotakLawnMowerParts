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

module mainPart(isLeft = true)
{

        // The outer base part
        mountBasePart(isLeft = isLeft);

        %union() 
        {
            // Inner handle pole
        translate( [baseMountLength / 2, 0, baseMountWidth / 2] ) 
        rotate([-90,0,0]) handlePole();    

        // The hinge part
        hingePart(partWidth = 10, thicknes = jointPartWidth);

        }

        

    
}

module mountBasePart(isLeft = true) {
    
    %difference() {
        // Outer cube
        cube([baseMountLength ,baseMountPartWidth, baseMountWidth]);
        
        // Inner cylinder cutout
        translate([0,baseMountPartWidth,baseMountPartWidth]) 
        rotate([0,90,0])
        cylinder(h =baseMountLength, r = mowerHandleRadius);
    }

    mountRimJoiner(length = baseMountLength - 4);
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

mainPart();
//handlePole();
//mountPart();
//jointPart(partWidth = 10, thicknes = jointPartWidth);

//color("blue") jointPart(partWidth = 10, thicknes = 2);