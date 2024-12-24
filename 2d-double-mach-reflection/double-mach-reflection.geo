// Domain parameters
w = 4.0;    // width of domain
h = 1.0;    // height of domain
t = 1/6;    // trip location

// Mesh parameters
Nx = 960;  // Number of elements in x-direction (change this value as needed)
Ny = 240;   // Number of elements in y-direction (change this value as needed)
Nx_slip = Round(Nx * (t/w)); // Number of elements in slip region
lc = 1.0 / Ny; // Characteristic length for mesh size

// Create points
Point(1) = {0, 0, 0, lc};
Point(2) = {t, 0, 0, lc};
Point(3) = {w, 0, 0, lc};
Point(4) = {w, h, 0, lc};
Point(5) = {t, h, 0, lc};
Point(6) = {0, h, 0, lc};

// Create lines
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 1};
Line(7) = {5, 2}; // midline

// Create surfaces
Curve Loop(1) = {1, -7, 5, 6};
Plane Surface(1) = {1};
Curve Loop(2) = {2, 3, 4, 7};
Plane Surface(2) = {2};

// Define Transfinite Lines
Transfinite Curve {1, 5} = Nx_slip + 1 Using Progression 1;
Transfinite Curve {2, 4} = Nx - Nx_slip + 1 Using Progression 1;
Transfinite Curve {3, 6, 7} = Ny + 1 Using Progression 1;

// Define transfinite surfaces
Transfinite Surface {1};
Transfinite Surface {2};

// Recombine surfaces into quads
Recombine Surface {1, 2};

// Assign physical names
Physical Surface("fluid") = {1, 2};
Physical Curve("wall") = {1};
Physical Curve("bottom") = {2};
Physical Curve("right") = {3};
Physical Curve("top") = {4, 5};
Physical Curve("left") = {6};

// Specify element types to generate
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements
