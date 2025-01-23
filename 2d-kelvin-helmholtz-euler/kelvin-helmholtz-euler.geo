//=============================================================================
// Kelvin-Helmholtz Instability - Structured Mesh Definition
// 
// Description:
// This file defines a structured mesh for simulating the Kelvin-Helmholtz
// instability using the Euler equations. The domain is periodic in both
// directions to allow for proper instability development.
//=============================================================================

//-----------------------------------------------------------------------------
// Domain Parameters (assumed normalized units)
//-----------------------------------------------------------------------------
w = 2.0;        // Width of domain
h = 2.0;        // Height of domain

//-----------------------------------------------------------------------------
// Mesh Resolution Parameters
//-----------------------------------------------------------------------------
Nx = 256;       // Elements in x direction
Ny = 256;       // Elements in y direction

//-----------------------------------------------------------------------------
// Point Definitions
//-----------------------------------------------------------------------------
Point(1) = {-w/2, -h/2, 0};    // Bottom left
Point(2) = {w/2, -h/2, 0};     // Bottom right
Point(3) = {w/2, h/2, 0};      // Top right
Point(4) = {-w/2, h/2, 0};     // Top left

//-----------------------------------------------------------------------------
// Line Definitions
//-----------------------------------------------------------------------------
Line(1) = {1, 2};  // Bottom
Line(2) = {2, 3};  // Right
Line(3) = {3, 4};  // Top
Line(4) = {4, 1};  // Left

//-----------------------------------------------------------------------------
// Surface Definitions
//-----------------------------------------------------------------------------
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

//-----------------------------------------------------------------------------
// Mesh Control - Transfinite Lines
//-----------------------------------------------------------------------------
// Uniform mesh spacing in both directions
Transfinite Curve {1, 3} = Nx + 1 Using Progression 1.0;  // Horizontal
Transfinite Curve {2, 4} = Ny + 1 Using Progression 1.0;  // Vertical

//-----------------------------------------------------------------------------
// Mesh Generation Controls
//-----------------------------------------------------------------------------
// Define transfinite surface
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangles into quadrilateral elements
Recombine Surface {1};

//-----------------------------------------------------------------------------
// Periodic Boundary Conditions
//-----------------------------------------------------------------------------
Periodic Curve {3} = {1} Translate {0, h, 0};   // Vertical periodicity
Periodic Curve {2} = {4} Translate {w, 0, 0};   // Horizontal periodicity

//-----------------------------------------------------------------------------
// Physical Groups for Boundary Condition Assignment
//-----------------------------------------------------------------------------
Physical Surface("Fluid") = {1};
Physical Curve("periodic_0_r") = {2};
Physical Curve("periodic_0_l") = {4};
Physical Curve("periodic_1_r") = {3};
Physical Curve("periodic_1_l") = {1};

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
