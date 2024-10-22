RSRC                    VisualShader            ��������                                            l      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame 	   constant    script    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    source    texture    texture_type    input_name    parameter_name 
   qualifier    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections     	   ,   local://VisualShaderNodeFloatConstant_kom5b       ,   local://VisualShaderNodeFloatConstant_rk2no A         local://Gradient_mv20m {         local://FastNoiseLite_pbo1w �         local://NoiseTexture2D_wu7wk �      &   local://VisualShaderNodeTexture_px77g A      $   local://VisualShaderNodeInput_s2uvx �      -   local://VisualShaderNodeColorParameter_rtqvk �      ,   res://Art/materials/props/metal_bright.tres          VisualShaderNodeFloatConstant            �?         VisualShaderNodeFloatConstant             ?      	   Gradient       $      �?�?�?  �?  �?  �?  �?  �?         FastNoiseLite          #��<         NoiseTexture2D    (         *          +            ,                     VisualShaderNodeTexture    .            /                  VisualShaderNodeInput    0         uv          VisualShaderNodeColorParameter    1         BaseColour 3                  VisualShader    5      ~  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 BaseColour : source_color = vec4(1.000000, 1.000000, 1.000000, 1.000000);
uniform sampler2D tex_frg_4 : hint_normal;



void fragment() {
// ColorParameter:6
	vec4 n_out6p0 = BaseColour;


// FloatConstant:2
	float n_out2p0 = 1.000000;


// FloatConstant:3
	float n_out3p0 = 0.500000;


// Input:5
	vec2 n_out5p0 = UV;


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, n_out5p0);


// Output:0
	ALBEDO = vec3(n_out6p0.xyz);
	METALLIC = n_out2p0;
	ROUGHNESS = n_out3p0;
	NORMAL_MAP = vec3(n_out4p0.xyz);


}
 Q             R   
     �B  pCS            T   
     �B  �CU            V   
     p�  �CW            X   
     �  �CY            Z   
     pB  �A[                                                 	                                      RSRC