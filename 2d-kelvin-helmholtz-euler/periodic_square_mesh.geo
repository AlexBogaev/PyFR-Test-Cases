// Mesh parameters
N = 256;    // Number of elements in each direction (change this value as needed)
lc = 2.0 / N;  // Characteristic length for mesh size

// Create geometry
Point(1) = {-1, -1, 0, lc};
Point(2) = {1, -1, 0, lc};
Point(3) = {1, 1, 0, lc};
Point(4) = {-1, 1, 0, lc};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Assign physical names
Physical Surface("Fluid") = {1};
Physical Curve("periodic_0_r") = {2};
Physical Curve("periodic_0_l") = {4};
Physical Curve("periodic_1_r") = {3};
Physical Curve("periodic_1_l") = {1};

// Create structured grid
Transfinite Curve {1, 2, 3, 4} = N + 1 Using Progression 1;
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangular elements into quads
Recombine Surface {1};

// Apply periodic boundary conditions
Periodic Curve {3} = {1} Translate {0, 2, 0};
Periodic Curve {2} = {4} Translate {2, 0, 0};

// Specify element types to generate
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

