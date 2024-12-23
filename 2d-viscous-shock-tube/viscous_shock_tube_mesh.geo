// Mesh parameters
N = 1024;    // Number of elements in each direction (change this value as needed)
lc = 1.0 / N;  // Characteristic length for mesh size

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements

// Create geometry
Point(1) = {-0.5, 0, 0, lc};
Point(2) = {-0.5, -0.5, 0, lc};
Point(3) = {0.5, -0.5, 0, lc};
Point(4) = {0.5, 0, 0, lc};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Assign physical names
Physical Surface("fluid") = {1};
Physical Curve("wall") = {1, 2, 3};
Physical Curve("sym") = {4};

// Create structured grid
Transfinite Curve {1, 3} = N / 2 + 1 Using Progression 1;
Transfinite Curve {2, 4} = N + 1 Using Progression 1;
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangular elements into quads
Recombine Surface {1};

// Specify element types to generate
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

