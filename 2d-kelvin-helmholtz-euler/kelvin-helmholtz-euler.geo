// Domain parameters
w = 2.0;    // width of domain
h = 2.0;    // height of domain

// Mesh parameters
Nx = 256;   // Number of elements in x-direction (change this value as needed)
Ny = 256;   // Number of elements in y-direction (change this value as needed)

// Create points
Point(1) = {-w/2, -h/2, 0};
Point(2) = {w/2, -h/2, 0};
Point(3) = {w/2, h/2, 0};
Point(4) = {-w/2, h/2, 0};

// Create lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

// Create surfaces
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Create structured grid
Transfinite Curve {1, 3} = Nx + 1 Using Progression 1;
Transfinite Curve {2, 4} = Ny + 1 Using Progression 1;
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangular elements into quads
Recombine Surface {1};

// Apply periodic boundary conditions
Periodic Curve {3} = {1} Translate {0, h, 0};
Periodic Curve {2} = {4} Translate {w, 0, 0};

// Assign physical names
Physical Surface("Fluid") = {1};
Physical Curve("periodic_0_r") = {2};
Physical Curve("periodic_0_l") = {4};
Physical Curve("periodic_1_r") = {3};
Physical Curve("periodic_1_l") = {1};

// Specify element types to generate
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements
