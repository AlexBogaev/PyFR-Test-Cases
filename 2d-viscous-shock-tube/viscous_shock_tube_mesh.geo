// Domain parameters
w = 1.0;    // width of domain
h = 0.5;    // height of domain

// Mesh parameters
Nx = 1024;  // Number of elements in x-direction (change this value as needed)
Ny = 512;   // Number of elements in y-direction (change this value as needed)

// Create points
Point(1) = {-w/2, 0, 0};
Point(2) = {-w/2, -h, 0};
Point(3) = {w/2, -h, 0};
Point(4) = {w/2, 0, 0};

// Create lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

// Create surfaces
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Assign physical names
Physical Surface("fluid") = {1};
Physical Curve("wall") = {1, 2, 3};
Physical Curve("sym") = {4};

// Create structured grid
Transfinite Curve {1, 3} = Ny + 1 Using Progression 1;
Transfinite Curve {2, 4} = Nx + 1 Using Progression 1;
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangular elements into quads
Recombine Surface {1};

// Specify element types to generate
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements
