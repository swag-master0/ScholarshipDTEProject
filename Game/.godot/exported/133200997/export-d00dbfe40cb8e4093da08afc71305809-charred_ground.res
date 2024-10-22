RSRC                    VisualShader            ��������                                            f      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    input_name 	   constant    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_5wh64 �         local://FastNoiseLite_dgikg          local://NoiseTexture2D_ef3s8 R      &   local://VisualShaderNodeTexture_gdhw8 �      $   local://VisualShaderNodeInput_tqfr1 �      ,   local://VisualShaderNodeFloatConstant_5a7ya �         local://Gradient_um5q2 ,         local://FastNoiseLite_0mjii Y         local://NoiseTexture2D_v36tt �      &   local://VisualShaderNodeTexture_dmlbe �      (   res://Art/materials/charred_ground.tres       	   Gradient                !          ��
?   $                    �?5��>W��>5��>  �?         FastNoiseLite             	      Z�=         NoiseTexture2D    &             '                     VisualShaderNodeTexture    -                     VisualShaderNodeInput    /         uv          VisualShaderNodeFloatConstant          	   Gradient       !          [�)?         FastNoiseLite    	      ��>         NoiseTexture2D    #         $      ��,@&            '                     VisualShaderNodeTexture    -                     VisualShader    1      2  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_2;
uniform sampler2D tex_frg_15;



void fragment() {
// Input:3
	vec2 n_out3p0 = UV;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);


// FloatConstant:14
	float n_out14p0 = 0.000000;


// Texture2D:15
	vec4 n_out15p0 = texture(tex_frg_15, n_out3p0);


// Output:0
	ALBEDO = vec3(n_out2p0.xyz);
	METALLIC = n_out14p0;
	ROUGHNESS = n_out14p0;
	SPECULAR = n_out14p0;
	NORMAL_MAP = vec3(n_out15p0.xyz);


}
 M            N   
     ��  CO            P   
      �  �CQ            R   
     �A  �CS         	   T   
     \�  DU                                                                                            	                       RSRC