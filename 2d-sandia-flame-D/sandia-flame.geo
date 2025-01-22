//=============================================================================
// Sandia Flame D - Structured Mesh Definition
// 
// Description:
// This file defines a structured mesh for the Sandia Flame D configuration,
// which consists of three concentric streams: fuel, pilot, and coflow air.
// The domain includes an entry region and a primary combustion region.
//=============================================================================

//-----------------------------------------------------------------------------
// Domain Parameters (all dimensions in meters)
//-----------------------------------------------------------------------------
// Radial dimensions
Rmax_fuel = 0.0072;     // Outer radius of fuel stream
Rmin_pilot = 0.0077;    // Inner radius of pilot stream
Rmax_pilot = 0.0182;    // Outer radius of pilot stream
Rmin_air = 0.0189;      // Inner radius of coflow air
Rmax_air = 0.300;       // Outer radius of domain

// Axial dimensions
Lentry = 0.010;         // Length of entry region
Lprimary = (0.900 - Lentry);  // Length of primary combustion region

//-----------------------------------------------------------------------------
// Mesh Resolution Parameters
//-----------------------------------------------------------------------------
// Axial resolution
nx_entry = 20;          // Elements in entry region
nx_primary = 300;       // Elements in primary region

// Radial resolution
nr_fuel = 15;           // Elements across fuel inlet
nr_pilot = 25;          // Elements across pilot region
nr_air = 125;          // Elements across air region
nr_wall = 2;           // Elements across wall regions

//-----------------------------------------------------------------------------
// Point Definitions
//-----------------------------------------------------------------------------
// Entry plane points (x = -Lentry)
Point(1) = {-Lentry, 0, 0};           // Centerline
Point(2) = {-Lentry, Rmax_fuel, 0};   // Fuel outer radius
Point(3) = {-Lentry, Rmin_pilot, 0};  // Pilot inner radius
Point(4) = {-Lentry, Rmax_pilot, 0};  // Pilot outer radius
Point(5) = {-Lentry, Rmin_air, 0};    // Air inner radius
Point(6) = {-Lentry, Rmax_air, 0};    // Domain outer radius

// Nozzle exit plane points (x = 0)
Point(7) = {0, 0, 0};
Point(8) = {0, Rmax_fuel, 0};
Point(9) = {0, Rmin_pilot, 0};
Point(10) = {0, Rmax_pilot, 0};
Point(11) = {0, Rmin_air, 0};
Point(12) = {0, Rmax_air, 0};

// Outlet plane points (x = Lprimary)
Point(13) = {Lprimary, 0, 0};
Point(14) = {Lprimary, Rmax_fuel, 0};
Point(15) = {Lprimary, Rmin_pilot, 0};
Point(16) = {Lprimary, Rmax_pilot, 0};
Point(17) = {Lprimary, Rmin_air, 0};
Point(18) = {Lprimary, Rmax_air, 0};

//-----------------------------------------------------------------------------
// Line Definitions
//-----------------------------------------------------------------------------
// Entry plane radial lines
Line(1) = {1, 2};  // Fuel inlet
Line(2) = {3, 4};  // Pilot inlet
Line(3) = {5, 6};  // Air inlet

// Nozzle exit plane radial lines
Line(4) = {7, 8};
Line(5) = {8, 9};   // Fuel-pilot wall
Line(6) = {9, 10};
Line(7) = {10, 11}; // Pilot-air wall
Line(8) = {11, 12};

// Outlet plane radial lines
Line(9) = {13, 14};
Line(10) = {14, 15};
Line(11) = {15, 16};
Line(12) = {16, 17};
Line(13) = {17, 18};

// Axial lines - entry region
Line(14) = {1, 7};   // Centerline/symmetry
Line(15) = {2, 8};   // Fuel wall
Line(16) = {3, 9};   // Pilot inner wall
Line(17) = {4, 10};  // Pilot outer wall
Line(18) = {5, 11};  // Air inner wall
Line(19) = {6, 12};  // Domain outer boundary

// Axial lines - primary region
Line(20) = {7, 13};  // Centerline/symmetry
Line(21) = {8, 14};
Line(22) = {9, 15};
Line(23) = {10, 16};
Line(24) = {11, 17};
Line(25) = {12, 18}; // Domain outer boundary

//-----------------------------------------------------------------------------
// Surface Definitions
//-----------------------------------------------------------------------------
// Entry region surfaces
Curve Loop(1) = {14, 4, -15, -1};
Plane Surface(1) = {1};  // Fuel entry
Curve Loop(2) = {16, 6, -17, -2};
Plane Surface(2) = {2};  // Pilot entry
Curve Loop(3) = {18, 8, -19, -3};
Plane Surface(3) = {3};  // Air entry

// Primary region surfaces
Curve Loop(4) = {20, 9, -21, -4};
Plane Surface(4) = {4};  // Fuel region
Curve Loop(5) = {21, 10, -22, -5};
Plane Surface(5) = {5};  // Fuel-pilot region
Curve Loop(6) = {22, 11, -23, -6};
Plane Surface(6) = {6};  // Pilot region
Curve Loop(7) = {23, 12, -24, -7};
Plane Surface(7) = {7};  // Pilot-air region
Curve Loop(8) = {24, 13, -25, -8};
Plane Surface(8) = {8};  // Air region

//-----------------------------------------------------------------------------
// Mesh Control - Transfinite Lines
//-----------------------------------------------------------------------------
// Radial lines with uniform/expanding distributions
Transfinite Line {1} = nr_fuel + 1 Using Progression 1.0;   // Fuel
Transfinite Line {2} = nr_pilot + 1 Using Progression 1.0;  // Pilot
Transfinite Line {3} = nr_air + 1 Using Progression 1.02;   // Air (slight expansion)

// Nozzle exit radial lines
Transfinite Line {4} = nr_fuel + 1 Using Progression 1.0;
Transfinite Line {5} = nr_wall + 1 Using Progression 1.0;
Transfinite Line {6} = nr_pilot + 1 Using Progression 1.0;
Transfinite Line {7} = nr_wall + 1 Using Progression 1.0;
Transfinite Line {8} = nr_air + 1 Using Progression 1.02;

// Outlet radial lines
Transfinite Line {9} = nr_fuel + 1 Using Progression 1.0;
Transfinite Line {10} = nr_wall + 1 Using Progression 1.0;
Transfinite Line {11} = nr_pilot + 1 Using Progression 1.0;
Transfinite Line {12} = nr_wall + 1 Using Progression 1.0;
Transfinite Line {13} = nr_air + 1 Using Progression 1.02;

// Axial lines
Transfinite Line {14, 15, 16, 17, 18, 19} = nx_entry + 1 Using Progression 1.0;
Transfinite Line {20, 21, 22, 23, 24, 25} = nx_primary + 1 Using Progression 1.01;

//-----------------------------------------------------------------------------
// Mesh Generation Controls
//-----------------------------------------------------------------------------
// Define transfinite surfaces
Transfinite Surface {1, 2, 3, 4, 5, 6, 7, 8};

// Recombine triangles into quadrilateral elements
Recombine Surface {1, 2, 3, 4, 5, 6, 7, 8};

//-----------------------------------------------------------------------------
// Physical Groups for Boundary Condition Assignment
//-----------------------------------------------------------------------------
Physical Surface("fluid") = {1, 2, 3, 4, 5, 6, 7, 8};
Physical Curve("inlet_fuel") = {1};
Physical Curve("inlet_pilot") = {2};
Physical Curve("inlet_air") = {3};
Physical Curve("wall") = {5, 7, 15, 16, 17, 18};
Physical Curve("free") = {19, 25};
Physical Curve("outlet") = {9, 10, 11, 12, 13};
Physical Curve("symmetry") = {14, 20};

//-----------------------------------------------------------------------------
// Mesh Generation Parameters
//-----------------------------------------------------------------------------
Mesh.ElementOrder = 1;          // Linear elements
Mesh.SecondOrderLinear = 0;     // Disable second order
Mesh.SubdivisionAlgorithm = 0;  // No subdivision

//-----------------------------------------------------------------------------
// Output Control
//-----------------------------------------------------------------------------
Mesh.SaveAll = 0;               // Save only specified elements
Mesh.SaveElementTagType = 2;    // Save only physical elements