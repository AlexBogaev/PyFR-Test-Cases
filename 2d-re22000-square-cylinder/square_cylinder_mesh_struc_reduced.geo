// Square cylinder mesh for PyFR simulation

// Global mesh size factor (adjust this to change overall mesh resolution)
invFAC = 2;

// Parameters
D = 0.01;  // Cylinder width
L = 30.5 * D; // Domain length
H = 14.0 * D; // Domain height
x0 = 10.0 * D; // Distance from inlet to cylinder
Geometry.Tolerance = 1e-6;

// Number of elements in each direction
nx_upstream = 100 * invFAC;
nx_downstream = 195 * invFAC;
nx_cylinder = 10 * invFAC;
ny_cylinder = 10 * invFAC;
ny_topside = 70 * invFAC;
ny_bottomside = 70 * invFAC;

// Create points
Point(1) = {0, -H/2, 0, invFAC};
Point(2) = {x0, -H/2, 0, invFAC};
Point(3) = {x0, -D/2, 0, invFAC};
Point(4) = {x0+D, -D/2, 0, invFAC};
Point(5) = {x0+D, -H/2, 0, invFAC};
Point(6) = {L, -H/2, 0, invFAC};
Point(7) = {L, -D/2, 0, invFAC};
Point(8) = {L, D/2, 0, invFAC};
Point(9) = {L, H/2, 0, invFAC};
Point(10) = {x0+D, H/2, 0, invFAC};
Point(11) = {x0, H/2, 0, invFAC};
Point(12) = {0, H/2, 0, invFAC};
Point(13) = {0, D/2, 0, invFAC};
Point(14) = {0, -D/2, 0, invFAC};
Point(15) = {x0, D/2, 0, invFAC};
Point(16) = {x0+D, D/2, 0, invFAC};

// Create lines
Line(1) = {1, 14};
Line(2) = {14, 3};
Line(3) = {3, 2};
Line(4) = {2, 1};
Line(5) = {13, 12};
Line(6) = {12, 11};
Line(7) = {11, 15};
Line(8) = {15, 13};
Line(9) = {16, 10};
Line(10) = {10, 9};
Line(11) = {9, 8};
Line(12) = {8, 16};
Line(13) = {5, 4};
Line(14) = {4, 7};
Line(15) = {7, 6};
Line(16) = {6, 5};
Line(17) = {14, 13};
Line(18) = {15, 3};
Line(19) = {11, 10};
Line(20) = {16, 15};
Line(21) = {4, 16};
Line(22) = {8, 7};
Line(23) = {3, 4};
Line(24) = {5, 2};

// Create surfaces
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};
Curve Loop(2) = {5, 6, 7, 8};
Plane Surface(2) = {2};
Curve Loop(3) = {9, 10, 11, 12};
Plane Surface(3) = {3};
Curve Loop(4) = {13, 14, 15, 16};
Plane Surface(4) = {4};
Curve Loop(5) = {17, -8, 18, -2};
Plane Surface(5) = {5};
Curve Loop(6) = {19, -9, 20, -7};
Plane Surface(6) = {6};
Curve Loop(7) = {21, -12, 22, -14};
Plane Surface(7) = {7};
Curve Loop(8) = {23, -13, 24, -3};
Plane Surface(8) = {8};

// Define Transfinite Lines
Transfinite Line {4, 2, 8, 6} = nx_upstream + 1 Using Progression 1;
Transfinite Line {16, 14, 12, 10} = nx_downstream + 1 Using Progression 1;
Transfinite Line {5, 7, 9, 11} = ny_topside + 1 Using Progression 1;
Transfinite Line {1, 3, 13, 15} = ny_bottomside + 1 Using Progression 1;
Transfinite Line {24, 23, 20, 19} = nx_cylinder + 1 Using Progression 1;
Transfinite Line {17, 18, 21, 22} = ny_cylinder + 1 Using Progression 1;

// Define transfinite surfaces
Transfinite Surface {1};
Transfinite Surface {2};
Transfinite Surface {3};
Transfinite Surface {4};
Transfinite Surface {5};
Transfinite Surface {6};
Transfinite Surface {7};
Transfinite Surface {8};

// Recombine surfaces into quads
Recombine Surface {1, 5, 2, 6, 3, 7, 4, 8};

// Reorient the surface out-of-plane (avoid negative Jacobian)
ReverseMesh Surface {1, 5, 2, 6, 3, 7, 4, 8};

// Define physical groups
Physical Surface("Fluid") = {1, 5, 2, 6, 3, 7, 4, 8};
Physical Curve("Inlet") = {1, 17, 5};
Physical Curve("Outlet") = {15, 22, 11};
Physical Curve("Top") = {6, 19, 10};
Physical Curve("Bottom") = {4, 24, 16};
Physical Curve("Cylinder") = {18, 20, 21, 23};

// Mesh parameters
Mesh.RecombineAll = 1;
Mesh.Algorithm = 8; // Delaunay for quads
Mesh.ElementOrder = 1;
Mesh.SecondOrderLinear = 0;
Mesh.SubdivisionAlgorithm = 0;

// Save parameters
Mesh.SaveAll = 0; // Don't save all elements
Mesh.SaveElementTagType = 2; // Save only physical elements

