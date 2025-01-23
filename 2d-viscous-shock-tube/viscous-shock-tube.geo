//=============================================================================
// Viscous Shock Tube - Structured Mesh Definition
// 
// Description:
// This file defines a structured mesh for simulating a viscous shock tube
// problem. The domain is symmetric about the top boundary with no-slip walls
// on the remaining boundaries.
//=============================================================================

//-----------------------------------------------------------------------------
// Domain Parameters (assumed normalized units)
//-----------------------------------------------------------------------------
w = 1.0;         // Width of domain
h = 0.5;         // Height of domain

//-----------------------------------------------------------------------------
// Mesh Resolution Parameters
//-----------------------------------------------------------------------------
Nx = 400;        // Elements in x direction
Ny = 200;        // Elements in y direction

//-----------------------------------------------------------------------------
// Point Definitions
//-----------------------------------------------------------------------------
Point(1) = {-w/2, 0, 0};       // Top left
Point(2) = {-w/2, -h, 0};      // Bottom left
Point(3) = {w/2, -h, 0};       // Bottom right
Point(4) = {w/2, 0, 0};        // Top right

//-----------------------------------------------------------------------------
// Line Definitions
//-----------------------------------------------------------------------------
Line(1) = {1, 2};  // Left wall
Line(2) = {2, 3};  // Bottom wall
Line(3) = {3, 4};  // Right wall
Line(4) = {4, 1};  // Top symmetry line

//-----------------------------------------------------------------------------
// Surface Definitions
//-----------------------------------------------------------------------------
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

//-----------------------------------------------------------------------------
// Mesh Control - Transfinite Lines
//-----------------------------------------------------------------------------
Transfinite Curve {1, 3} = Ny + 1 Using Progression 1.0;  // Vertical
Transfinite Curve {2, 4} = Nx + 1 Using Progression 1.0;  // Horizontal

//-----------------------------------------------------------------------------
// Mesh Generation Controls
//-----------------------------------------------------------------------------
// Define transfinite surface
Transfinite Surface {1} = {1, 2, 3, 4};

// Recombine triangles into quadrilateral elements
Recombine Surface {1};

//-----------------------------------------------------------------------------
// Physical Groups for Boundary Condition Assignment
//-----------------------------------------------------------------------------
Physical Surface("fluid") = {1};
Physical Curve("wall") = {1, 2, 3};
Physical Curve("sym") = {4};

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
