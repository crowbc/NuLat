import math

# --- Configuration ---
material_choice = "pvt" # Using Undoped PVT
use_reflector = False       # Reflector Removed

# --- Dimensions (in mm) ---
inch = 25.4
cube_size = 2.5 * inch      # 63.5 mm
gap_size = 0.001 * inch     # 0.0254 mm
step_size = cube_size + gap_size
acrylic_thickness = 0.125 * inch # 3.175 mm

# Light Guide Parameters
lg_base_side = 2.45 * inch
lg_base_thick = 0.197 * inch
lg_taper_height = 2.756 * inch
lg_top_side = 1.811 * inch

# PMT Parameters 
pmt_radius = 25.0 
pmt_length = 100.0 
pmt_glass_thick = 2.0 

# Grid
imax = 5
jmax = 5
kmax = 5

# Spans & Offsets
total_x_span = imax * step_size - gap_size
total_y_span = jmax * step_size - gap_size
total_z_span = kmax * step_size - gap_size

offset_x = -total_x_span / 2.0 + cube_size / 2.0
offset_y = -total_y_span / 2.0 + cube_size / 2.0
offset_z = -total_z_span / 2.0 + cube_size / 2.0

# Enclosure
box_inner_x = total_x_span
box_inner_y = total_y_span
box_inner_z = total_z_span
box_outer_x = box_inner_x + 2 * acrylic_thickness
box_outer_y = box_inner_y + 2 * acrylic_thickness
box_outer_z = box_inner_z + 2 * acrylic_thickness

# World
wX = box_outer_x + 1000.0
wY = box_outer_y + 1000.0
wZ = box_outer_z + 1000.0

if (use_reflector):
    geo_fname_str = f"NULAT{imax}x{jmax}x{kmax}_instrumented_undoped.geo"
elif (material_choice == "pvt_li6"):
    geo_fname_str = f"NULAT{imax}x{jmax}x{kmax}_instrumented_Li6.geo"
else:
    geo_fname_str = f"NULAT{imax}x{jmax}x{kmax}_instrumented_undoped.geo"

# --- Geometry String ---
_str = f"""
// NuLat Geometry: {imax}x{jmax}x{kmax}
// Material: {material_choice}
// Reflector: None

{{
name: "GEO",
index: "world",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "",
type: "box",
size: [{wX/2.0:.4f}, {wY/2.0:.4f}, {wZ/2.0:.4f}],
material: "air",
color: [0.0, 0.0, 0.0],
invisible: 1,
}}

// Acrylic Enclosure
{{
name: "GEO",
index: "acrylic_box_outer",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{box_outer_x/2.0:.4f}, {box_outer_y/2.0:.4f}, {box_outer_z/2.0:.4f}],
position: [0.0, 0.0, 0.0],
material: "acrylic_uva_McMaster",
color: [0.8, 0.8, 1.0, 0.2],
drawstyle: "solid"
}}

// Air Volume
{{
name: "GEO",
index: "acrylic_box_inner",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_outer",
type: "box",
size: [{box_inner_x/2.0:.4f}, {box_inner_y/2.0:.4f}, {box_inner_z/2.0:.4f}],
position: [0.0, 0.0, 0.0],
material: "air",
color: [1.0, 1.0, 1.0, 0.1],
invisible: 1,
}}
"""

with open(geo_fname_str, "w") as f:
    print(_str, file=f)

    # --- 1. Generate PVT Cubes ---
    for k in range(kmax):
        for j in range(jmax):
            for i in range(imax):
                pos_x = offset_x + i * step_size
                pos_y = offset_y + j * step_size
                pos_z = offset_z + k * step_size
                
                cube_str = f"""
{{
name: "GEO",
index: "cube_{i}_{j}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "acrylic_box_inner",
type: "box",
size: [{cube_size/2.0:.4f}, {cube_size/2.0:.4f}, {cube_size/2.0:.4f}],
position: [{pos_x:.4f}, {pos_y:.4f}, {pos_z:.4f}],
material: "{material_choice}",
color: [1.0, 0.0, 1.0, 0.3],
drawstyle: "solid"
}}"""
                print(cube_str, file=f)

    # --- 2. Generate Light Guides & PMTs ---
    
    # --- +Z Face (Top) ---
    z_face_pos = box_outer_z / 2.0
    for i in range(imax):
        for j in range(jmax):
            cx = offset_x + i * step_size
            cy = offset_y + j * step_size
            cz = z_face_pos
            
            # LG Base
            base_z = cz + lg_base_thick/2.0
            print(f"""{{
name: "GEO",
index: "lg_base_z_{i}_{j}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_base_side/2.0:.4f}, {lg_base_side/2.0:.4f}, {lg_base_thick/2.0:.4f}],
position: [{cx:.4f}, {cy:.4f}, {base_z:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # LG Taper (Box Approx)
            taper_z = cz + lg_base_thick + lg_taper_height/2.0
            print(f"""{{
name: "GEO",
index: "lg_taper_z_{i}_{j}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_base_side/2.0:.4f}, {lg_base_side/2.0:.4f}, {lg_taper_height/2.0:.4f}],
position: [{cx:.4f}, {cy:.4f}, {taper_z:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # PMT (Cylinder)
            pmt_z = cz + lg_base_thick + lg_taper_height + pmt_length/2.0
            print(f"""{{
name: "GEO",
index: "pmt_z_{i}_{j}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: {pmt_radius:.4f},
size_z: {pmt_length/2.0:.4f},
position: [{cx:.4f}, {cy:.4f}, {pmt_z:.4f}],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}}""", file=f)


    # --- +X Face (Right) ---
    x_face_pos = box_outer_x / 2.0
    for j in range(jmax):
        for k in range(kmax):
            cx = x_face_pos
            cy = offset_y + j * step_size
            cz = offset_z + k * step_size
            
            # LG Base
            base_x = cx + lg_base_thick/2.0
            print(f"""{{
name: "GEO",
index: "lg_base_x_{j}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_base_thick/2.0:.4f}, {lg_base_side/2.0:.4f}, {lg_base_side/2.0:.4f}], 
position: [{base_x:.4f}, {cy:.4f}, {cz:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # LG Taper
            taper_x = cx + lg_base_thick + lg_taper_height/2.0
            print(f"""{{
name: "GEO",
index: "lg_taper_x_{j}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_taper_height/2.0:.4f}, {lg_base_side/2.0:.4f}, {lg_base_side/2.0:.4f}],
position: [{taper_x:.4f}, {cy:.4f}, {cz:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # PMT (Cylinder) - Rotated 90 Y
            pmt_x = cx + lg_base_thick + lg_taper_height + pmt_length/2.0
            print(f"""{{
name: "GEO",
index: "pmt_x_{j}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: {pmt_radius:.4f},
size_z: {pmt_length/2.0:.4f},
position: [{pmt_x:.4f}, {cy:.4f}, {cz:.4f}],
rotation: [0.0, 90.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}}""", file=f)


    # --- +Y Face (Back) ---
    y_face_pos = box_outer_y / 2.0
    for i in range(imax):
        for k in range(kmax):
            cx = offset_x + i * step_size
            cy = y_face_pos
            cz = offset_z + k * step_size
            
            # LG Base
            base_y = cy + lg_base_thick/2.0
            print(f"""{{
name: "GEO",
index: "lg_base_y_{i}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_base_side/2.0:.4f}, {lg_base_thick/2.0:.4f}, {lg_base_side/2.0:.4f}], 
position: [{cx:.4f}, {base_y:.4f}, {cz:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # LG Taper
            taper_y = cy + lg_base_thick + lg_taper_height/2.0
            print(f"""{{
name: "GEO",
index: "lg_taper_y_{i}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "box",
size: [{lg_base_side/2.0:.4f}, {lg_taper_height/2.0:.4f}, {lg_base_side/2.0:.4f}],
position: [{cx:.4f}, {taper_y:.4f}, {cz:.4f}],
material: "acrylic_uva_McMaster",
color: [0.0, 1.0, 1.0, 0.3],
drawstyle: "solid"
}}""", file=f)

            # PMT (Cylinder) - Rotated -90 X
            pmt_y = cy + lg_base_thick + lg_taper_height + pmt_length/2.0
            print(f"""{{
name: "GEO",
index: "pmt_y_{i}_{k}",
valid_begin: [0, 0],
valid_end: [0, 0],
mother: "world",
type: "tube",
r_max: {pmt_radius:.4f},
size_z: {pmt_length/2.0:.4f},
position: [{cx:.4f}, {pmt_y:.4f}, {cz:.4f}],
rotation: [-90.0, 0.0, 0.0],
material: "glass",
color: [1.0, 0.5, 0.0, 0.5],
drawstyle: "solid",
// --- SENSITIVE DETECTOR ---
sensitive_detector: "/NuLat/pmt/inner",
pmt_model: "r6095_h10534",
}}""", file=f)

print(f"Generated {geo_fname_str}")
