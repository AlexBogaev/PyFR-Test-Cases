//=============================================================================
// Mach 800 Astro Jet - Structured Mesh Definition
// 
// Description:
// This file defines a structured mesh for a Mach 800 astrophysical jet simulation.
// The domain consists of two regions: a lower inlet region and an upper expansion
// region, with appropriate boundary conditions for supersonic flow.
//=============================================================================

//-----------------------------------------------------------------------------
// Domain Parameters (assumed normalized units)
//-----------------------------------------------------------------------------
w = 1.5;         // Width of domain
h = 0.5;         // Height of domain
h_inlet = 0.05;  // Height of inlet region

//-----------------------------------------------------------------------------
// Mesh Resolution Parameters
//-----------------------------------------------------------------------------
nx = 2400;       // Elements in x direction
ny = 800;        // Elements in y direction
ny_inlet = Round(ny * (h_inlet/h));  // Elements in inlet region proportional to height

//-----------------------------------------------------------------------------
// Point Definitions
//-----------------------------------------------------------------------------
Point(1) = {0, 0, 0};           // Bottom left
Point(2) = {w, 0, 0};           // Bottom right
Point(3) = {w, h, 0};           // Top right
Point(4) = {0, h, 0};           // Top left
Point(5) = {0, h_inlet, 0};     // Inlet top
Point(6) = {w, h_inlet, 0};     // Outlet top

//-----------------------------------------------------------------------------
// Line Definitions
//-----------------------------------------------------------------------------
Line(1) = {1, 2};  // Bottom (symmetry)
Line(2) = {2, 6};  // Right lower
Line(3) = {6, 5};  // Middle interface
Line(4) = {5, 1};  // Left lower (inlet)
Line(6) = {6, 3};  // Right upper
Line(7) = {3, 4};  // Top (free boundary)
Line(8) = {4, 5};  // Left upper

//-----------------------------------------------------------------------------
// Surface Definitions
//-----------------------------------------------------------------------------
// Lower region (inlet)
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// Upper region (expansion)
Curve Loop(2) = {-3, 6, 7, 8};
Plane Surface(2) = {2};

//-----------------------------------------------------------------------------
// Mesh Control - Transfinite Lines
//-----------------------------------------------------------------------------
// Vertical lines
Transfinite Line {4, 2} = ny_inlet + 1 Using Progression 1.0;     // Inlet region
Transfinite Line {8, 6} = ny - ny_inlet + 1 Using Progression 1.0; // Expansion region

// Horizontal lines
Transfinite Line {1, 3, 7} = nx + 1 Using Progression 1.0;

//-----------------------------------------------------------------------------
// Mesh Generation Controls
//-----------------------------------------------------------------------------
// Define transfinite surfaces
Transfinite Surface {1, 2};

// Recombine triangles into quadrilateral elements
Recombine Surface {1, 2};

//-----------------------------------------------------------------------------
// Physical Groups for Boundary Condition Assignment
//-----------------------------------------------------------------------------
Physical Surface("fluid") = {1, 2};
Physical Curve("inlet") = {4};
Physical Curve("free") = {8};
Physical Curve("outlet") = {2, 6, 7};
Physical Curve("symmetry") = {1};

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
