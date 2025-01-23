//=============================================================================
// Double Mach Reflection - Structured Mesh Definition
// 
// Description:
// This file defines a structured mesh for simulating the double Mach reflection
// problem. The domain includes a slip region and wall boundary conditions for
// shock wave interaction studies.
//=============================================================================

//-----------------------------------------------------------------------------
// Domain Parameters (assumed normalized units)
//-----------------------------------------------------------------------------
w = 4.0;         // Width of domain
h = 1.0;         // Height of domain
t = 1/6;         // Width of slip region

//-----------------------------------------------------------------------------
// Mesh Resolution Parameters
//-----------------------------------------------------------------------------
Nx = 960;        // Elements in x direction
Ny = 240;        // Elements in y direction
Nx_slip = Round(Nx * (t/w));  // Elements in slip region

//-----------------------------------------------------------------------------
// Point Definitions
//-----------------------------------------------------------------------------
Point(1) = {0, 0, 0};      // Bottom left
Point(2) = {t, 0, 0};      // Bottom slip point
Point(3) = {w, 0, 0};      // Bottom right
Point(4) = {w, h, 0};      // Top right
Point(5) = {t, h, 0};      // Top slip point
Point(6) = {0, h, 0};      // Top left

//-----------------------------------------------------------------------------
// Line Definitions
//-----------------------------------------------------------------------------
Line(1) = {1, 2};  // Bottom left
Line(2) = {2, 3};  // Bottom right (wall)
Line(3) = {3, 4};  // Right boundary
Line(4) = {4, 5};  // Top right
Line(5) = {5, 6};  // Top left
Line(6) = {6, 1};  // Left boundary
Line(7) = {5, 2};

//-----------------------------------------------------------------------------
// Surface Definitions
//-----------------------------------------------------------------------------
// Left region (slip)
Curve Loop(1) = {1, -7, 5, 6};
Plane Surface(1) = {1};

// Right region (wall)
Curve Loop(2) = {2, 3, 4, 7};
Plane Surface(2) = {2};

//-----------------------------------------------------------------------------
// Mesh Control - Transfinite Lines
//-----------------------------------------------------------------------------
// Horizontal lines
Transfinite Curve {1, 5} = Nx_slip + 1 Using Progression 1.0;        // Slip region
Transfinite Curve {2, 4} = Nx - Nx_slip + 1 Using Progression 1.0;   // Wall region

// Vertical lines
Transfinite Curve {3, 6, 7} = Ny + 1 Using Progression 1.0;

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
Physical Curve("bottom") = {1};
Physical Curve("wall") = {2};
Physical Curve("right") = {3};
Physical Curve("top") = {4, 5};
Physical Curve("left") = {6};

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
