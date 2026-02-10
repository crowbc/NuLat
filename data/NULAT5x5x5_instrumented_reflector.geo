
// NuLat Geometry: 5x5x5
// Instrumented (+x, +y, +z faces) with Light Guides and PMTs
// Reflector Slabs (Polyethylene) on uninstrumented faces (-x, -y, -z)

{
name: "GEO",
index: "world",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "",
type: "box",
size: [761.9758, 761.9758, 761.9758],
material: "air",
color: [0.0, 0.0, 0.0],
invisible: 1,
}

// Acrylic Enclosure (Outer)
{
name: "GEO",
index: "acrylic_box_outer",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [161.9758, 161.9758, 161.9758],
position: [0.0, 0.0, 0.0],
material: "acrylic_uva_McMaster",
color: [0.8, 0.8, 1.0, 0.2],
drawstyle: "solid"
}

// Air Volume Inside Box (Inner)
{
name: "GEO",
index: "acrylic_box_inner",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_outer",
type: "box",
size: [158.8008, 158.8008, 158.8008],
position: [0.0, 0.0, 0.0],
material: "air",
color: [1.0, 1.0, 1.0, 0.1],
invisible: 1,
}

// --- REFLECTOR SLABS (Polyethylene) ---
// Placed on -X, -Y, -Z faces (Uninstrumented sides)

// -Z Face Reflector
{
name: "GEO",
index: "reflector_neg_z",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
// Size: Covers the full XY face of the acrylic box
size: [161.9758, 161.9758, 50.0000],
// Position: Shifted in -Z to touch the acrylic box
position: [0.0, 0.0, -211.9758],
material: "polyethylene",
color: [0.5, 0.5, 0.5, 0.5],
drawstyle: "solid"
}

// -X Face Reflector
{
name: "GEO",
index: "reflector_neg_x",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
// Size: Covers YZ face
size: [50.0000, 161.9758, 161.9758],
position: [-211.9758, 0.0, 0.0],
material: "polyethylene",
color: [0.5, 0.5, 0.5, 0.5],
drawstyle: "solid"
}

// -Y Face Reflector
{
name: "GEO",
index: "reflector_neg_y",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
// Size: Covers XZ face
size: [161.9758, 50.0000, 161.9758],
position: [0.0, -211.9758, 0.0],
material: "polyethylene",
color: [0.5, 0.5, 0.5, 0.5],
drawstyle: "solid"
}


{
name: "GEO",
index: "cube_0_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -0.0000, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -0.0000, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -0.0000, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -0.0000, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -0.0000, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 63.5254, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 127.0508, -127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -0.0000, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -0.0000, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -0.0000, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -0.0000, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -0.0000, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 63.5254, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 127.0508, -63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -0.0000, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -0.0000, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -0.0000, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -0.0000, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -0.0000, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 63.5254, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 127.0508, -0.0000],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -0.0000, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -0.0000, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -0.0000, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -0.0000, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -0.0000, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 63.5254, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 127.0508, 63.5254],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, -0.0000, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, -0.0000, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, -0.0000, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, -0.0000, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, -0.0000, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 63.5254, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_0_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-127.0508, 127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_1_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-63.5254, 127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_2_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [-0.0000, 127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_3_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [63.5254, 127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}

{
name: "GEO",
index: "cube_4_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [31.7500, 31.7500, 31.7500],
position: [127.0508, 127.0508, 127.0508],
material: "pvt",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_base_z_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-127.0508, -127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-127.0508, -127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, -127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-127.0508, -63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-127.0508, -63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, -63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-127.0508, -0.0000, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-127.0508, -0.0000, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, -0.0000, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-127.0508, 63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-127.0508, 63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-127.0508, 127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-127.0508, 127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-63.5254, -127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-63.5254, -127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, -127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-63.5254, -63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-63.5254, -63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, -63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-63.5254, -0.0000, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-63.5254, -0.0000, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, -0.0000, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-63.5254, 63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-63.5254, 63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-63.5254, 127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-63.5254, 127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-0.0000, -127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-0.0000, -127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, -127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-0.0000, -63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-0.0000, -63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, -63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-0.0000, -0.0000, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-0.0000, -0.0000, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, -0.0000, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-0.0000, 63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-0.0000, 63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [-0.0000, 127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [-0.0000, 127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [63.5254, -127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [63.5254, -127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, -127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [63.5254, -63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [63.5254, -63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, -63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [63.5254, -0.0000, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [63.5254, -0.0000, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, -0.0000, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [63.5254, 63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [63.5254, 63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [63.5254, 127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [63.5254, 127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [127.0508, -127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [127.0508, -127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, -127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [127.0508, -63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [127.0508, -63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, -63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [127.0508, -0.0000, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [127.0508, -0.0000, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, -0.0000, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [127.0508, 63.5254, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [127.0508, 63.5254, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 63.5254, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_z_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 2.5019],
position: [127.0508, 127.0508, 164.4777],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_z_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 31.1150, 35.0012],
position: [127.0508, 127.0508, 201.9808],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_z_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 127.0508, 286.9820],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -127.0508, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -127.0508, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -127.0508, -127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -127.0508, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -127.0508, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -127.0508, -63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -127.0508, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -127.0508, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -127.0508, -0.0000],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -127.0508, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -127.0508, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -127.0508, 63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -127.0508, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -127.0508, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -127.0508, 127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -63.5254, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -63.5254, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -63.5254, -127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -63.5254, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -63.5254, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -63.5254, -63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -63.5254, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -63.5254, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -63.5254, -0.0000],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -63.5254, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -63.5254, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -63.5254, 63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -63.5254, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -63.5254, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -63.5254, 127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -0.0000, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -0.0000, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -0.0000, -127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -0.0000, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -0.0000, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -0.0000, -63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -0.0000, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -0.0000, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -0.0000, -0.0000],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -0.0000, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -0.0000, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -0.0000, 63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, -0.0000, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, -0.0000, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, -0.0000, 127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 63.5254, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 63.5254, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 63.5254, -127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 63.5254, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 63.5254, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 63.5254, -63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 63.5254, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 63.5254, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 63.5254, -0.0000],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 63.5254, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 63.5254, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 63.5254, 63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 63.5254, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 63.5254, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 63.5254, 127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 127.0508, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 127.0508, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 127.0508, -127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 127.0508, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 127.0508, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 127.0508, -63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 127.0508, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 127.0508, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 127.0508, -0.0000],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 127.0508, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 127.0508, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 127.0508, 63.5254],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_x_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [2.5019, 31.1150, 31.1150], 
position: [164.4777, 127.0508, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_x_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [35.0012, 31.1150, 31.1150],
position: [201.9808, 127.0508, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_x_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [286.9820, 127.0508, 127.0508],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-127.0508, 164.4777, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-127.0508, 201.9808, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_0_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 286.9820, -127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-127.0508, 164.4777, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-127.0508, 201.9808, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_0_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 286.9820, -63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-127.0508, 164.4777, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-127.0508, 201.9808, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_0_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 286.9820, -0.0000],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-127.0508, 164.4777, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-127.0508, 201.9808, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_0_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 286.9820, 63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-127.0508, 164.4777, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-127.0508, 201.9808, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_0_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-127.0508, 286.9820, 127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-63.5254, 164.4777, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-63.5254, 201.9808, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_1_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 286.9820, -127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-63.5254, 164.4777, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-63.5254, 201.9808, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_1_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 286.9820, -63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-63.5254, 164.4777, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-63.5254, 201.9808, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_1_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 286.9820, -0.0000],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-63.5254, 164.4777, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-63.5254, 201.9808, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_1_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 286.9820, 63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-63.5254, 164.4777, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-63.5254, 201.9808, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_1_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-63.5254, 286.9820, 127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-0.0000, 164.4777, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-0.0000, 201.9808, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_2_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 286.9820, -127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-0.0000, 164.4777, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-0.0000, 201.9808, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_2_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 286.9820, -63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-0.0000, 164.4777, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-0.0000, 201.9808, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_2_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 286.9820, -0.0000],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-0.0000, 164.4777, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-0.0000, 201.9808, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_2_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 286.9820, 63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [-0.0000, 164.4777, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [-0.0000, 201.9808, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_2_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [-0.0000, 286.9820, 127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [63.5254, 164.4777, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [63.5254, 201.9808, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_3_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 286.9820, -127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [63.5254, 164.4777, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [63.5254, 201.9808, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_3_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 286.9820, -63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [63.5254, 164.4777, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [63.5254, 201.9808, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_3_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 286.9820, -0.0000],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [63.5254, 164.4777, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [63.5254, 201.9808, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_3_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 286.9820, 63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [63.5254, 164.4777, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [63.5254, 201.9808, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_3_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [63.5254, 286.9820, 127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [127.0508, 164.4777, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [127.0508, 201.9808, -127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_4_0",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 286.9820, -127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [127.0508, 164.4777, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [127.0508, 201.9808, -63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_4_1",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 286.9820, -63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [127.0508, 164.4777, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [127.0508, 201.9808, -0.0000],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_4_2",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 286.9820, -0.0000],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [127.0508, 164.4777, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [127.0508, 201.9808, 63.5254],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_4_3",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 286.9820, 63.5254],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
{
name: "GEO",
index: "lg_base_y_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 2.5019, 31.1150], 
position: [127.0508, 164.4777, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "lg_taper_y_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [31.1150, 35.0012, 31.1150],
position: [127.0508, 201.9808, 127.0508],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}
{
name: "GEO",
index: "pmt_y_4_4",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: 25.0000,
size_z: 50.0000,
position: [127.0508, 286.9820, 127.0508],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}
