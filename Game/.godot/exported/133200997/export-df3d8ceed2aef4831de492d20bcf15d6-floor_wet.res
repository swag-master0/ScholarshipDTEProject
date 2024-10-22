RSRC                    VisualShader            ��������                                            k      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    script    input_name 	   constant    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise 	   operator    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections    
   Texture2D ,   res://Art/materials/floor/floor_normal.tres �*�c���&
   &   local://VisualShaderNodeTexture_056ve g      $   local://VisualShaderNodeInput_eg63u �      ,   local://VisualShaderNodeColorConstant_5w1y1 �         local://Gradient_8nity &         local://FastNoiseLite_cw1g5 _         local://NoiseTexture2D_3vb8s �      &   local://VisualShaderNodeTexture_5lq6d �      &   local://VisualShaderNodeFloatOp_ar38h       ,   local://VisualShaderNodeFloatConstant_4oity x      #   res://Art/materials/floor_wet.tres �         VisualShaderNodeTexture                          	         VisualShaderNodeInput    
         uv 	         VisualShaderNodeColorConstant          �z?w.p?�9?  �?	      	   Gradient                !          �P�>	         FastNoiseLite          �0�<	         NoiseTexture2D    *         /            0            	         VisualShaderNodeTexture                	         VisualShaderNodeFloatOp                                                 @1         	         VisualShaderNodeFloatConstant    	         VisualShader    2      �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_5;
uniform sampler2D tex_frg_2 : hint_normal;



void fragment() {
// ColorConstant:4
	vec4 n_out4p0 = vec4(0.505780, 0.938209, 0.725007, 1.000000);


// FloatConstant:9
	float n_out9p0 = 0.000000;


// Input:3
	vec2 n_out3p0 = UV;


// Texture2D:5
	vec4 n_out5p0 = texture(tex_frg_5, n_out3p0);


// FloatOp:8
	float n_in8p1 = 2.00000;
	float n_out8p0 = n_out5p0.x * n_in8p1;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);


// Output:0
	ALBEDO = vec3(n_out4p0.xyz);
	ROUGHNESS = n_out9p0;
	SPECULAR = n_out8p0;
	NORMAL_MAP = vec3(n_out2p0.xyz);


}
 N             O   
     4�   DP            Q   
     a�  �CR            S   
     4C   CT            U   
     ��  �CV            W   
     4�  �CX            Y   
      B  �CZ                                   	                                                            	              	      RSRC