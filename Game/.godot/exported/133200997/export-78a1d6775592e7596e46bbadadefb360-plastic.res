RSRC                    VisualShader            ��������                                            j      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    parameter_name 
   qualifier    default_value_enabled    default_value    script    input_name    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    source    texture    texture_type 	   constant    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        -   local://VisualShaderNodeColorParameter_u7f1e �      $   local://VisualShaderNodeInput_vxiir �         local://Gradient_mabdd          local://FastNoiseLite_hl1t7 R         local://NoiseTexture2D_3x3ka �      &   local://VisualShaderNodeTexture_50ng7 �      ,   local://VisualShaderNodeFloatConstant_xbyjv       '   res://Art/materials/props/plastic.tres E         VisualShaderNodeColorParameter             BaseColour          
         VisualShaderNodeInput             uv 
      	   Gradient                !          �L
?
         FastNoiseLite                   M�N>
         NoiseTexture2D    ,         /            0            
         VisualShaderNodeTexture    2            
         VisualShaderNodeFloatConstant    4      ��L>
         VisualShader    5      0  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 BaseColour : source_color = vec4(1.000000, 1.000000, 1.000000, 1.000000);
uniform sampler2D tex_frg_4;



void fragment() {
// ColorParameter:2
	vec4 n_out2p0 = BaseColour;


// Input:3
	vec2 n_out3p0 = UV;


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, n_out3p0);


// FloatConstant:5
	float n_out5p0 = 0.200000;


// Output:0
	ALBEDO = vec3(n_out2p0.xyz);
	NORMAL_MAP = vec3(n_out4p0.xyz);
	NORMAL_MAP_DEPTH = n_out5p0;


}
 6   
   d�)����Q             R   
     ��   BS            T   
     �  �CU            V   
     H�  �CW            X   
     C  DY                                                  	              
   
      RSRC