// Domain parameters
w = 1.5;     // width of domain
h = 0.5;     // height of domain
h_inlet = 0.05;  // height of inlet region

// Mesh resolution parameters (coarse mesh)
nx = 2400;    // elements in x direction
ny = 800;    // elements in y direction
ny_inlet = Round(ny * (h_inlet/h)); // elements in inlet region proportional to height

// Create points
Point(1) = {0, 0, 0};           // bottom left
Point(2) = {w, 0, 0};           // bottom right
Point(3) = {w, h, 0};           // top right
Point(4) = {0, h, 0};           // top left
Point(5) = {0, h_inlet, 0};     // inlet top
Point(6) = {w, h_inlet, 0};     // outlet top

// Create lines
Line(1) = {1, 2};  // bottom
Line(2) = {2, 6};  // right lower
Line(3) = {6, 5};  // middle
Line(4) = {5, 1};  // left lower (inlet)
// Line(5) = {5, 6};  // middle
Line(6) = {6, 3};  // right upper
Line(7) = {3, 4};  // top
Line(8) = {4, 5};  // left upper

// Create surfaces
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {-3, 6, 7, 8};
Plane Surface(2) = {2};

// Define Transfinite Lines
Transfinite Line {4, 2} = ny_inlet + 1 Using Progression 1;
Transfinite Line {8, 6} = ny - ny_inlet + 1 Using Progression 1;
Transfinite Line {1, 3, 7} = nx + 1 Using Progression 1;

// Define transfinite surfaces
Transfinite Surface {1};
Transfinite Surface {2};

// Recombine surfaces into quads
Recombine Surface {1, 2};

// Define physical groups
Physical Surface("Fluid") = {1, 2};
Physical Curve("Inlet") = {4};
Physical Curve("Slip") = {8};
Physical Curve("Outlet") = {2, 6, 7};
Physical Curve("Symmetry") = {1};

// Mesh parameters
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements
