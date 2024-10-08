RSRC                    VisualShader            ��������                                            i      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    input_name 	   operator 	   constant    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_pl6pi &         local://FastNoiseLite_hj2de �         local://NoiseTexture2D_jt6u5 �      &   local://VisualShaderNodeTexture_2m8ht \      $   local://VisualShaderNodeInput_pjid8 �      &   local://VisualShaderNodeColorOp_7b8pg �      ,   local://VisualShaderNodeColorConstant_7k0a5 �         local://Gradient_8ujpf 7         local://FastNoiseLite_wtonj �         local://NoiseTexture2D_7p3am 
      &   local://VisualShaderNodeTexture_4vutg y      $   res://Art/materials/props/tree.tres �      	   Gradient       !      
��<7>  �?   $                    �?�`u?�`u?�`u?  �?  �?  �?  �?  �?         FastNoiseLite             	      �J�<                                    pA         NoiseTexture2D                      !         &             '                     VisualShaderNodeTexture    -                     VisualShaderNodeInput    /         uv          VisualShaderNodeColorOp             VisualShaderNodeColorConstant    1      ���=��>�0�=  �?      	   Gradient       !      
��< ��>  �?   $                    �?�`u?�`u?�`u?  �?  �?  �?  �?  �?         FastNoiseLite             	      �J�<                                    pA         NoiseTexture2D                      !         #         &            '                     VisualShaderNodeTexture    -         	            VisualShader    2      o  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_2;
uniform sampler2D tex_frg_6;



void fragment() {
// Input:3
	vec2 n_out3p0 = UV;


// Texture2D:2
	vec4 n_out2p0 = texture(tex_frg_2, n_out3p0);


// ColorConstant:5
	vec4 n_out5p0 = vec4(0.097105, 0.141551, 0.067476, 1.000000);


// ColorOp:4
	vec3 n_out4p0 = vec3(1.0) - (vec3(1.0) - vec3(n_out2p0.xyz)) * (vec3(1.0) - vec3(n_out5p0.xyz));


// Texture2D:6
	vec4 n_out6p0 = texture(tex_frg_6, n_out3p0);


// Output:0
	ALBEDO = n_out4p0;
	NORMAL_MAP = vec3(n_out6p0.xyz);


}
 N            O   
     \�  �CP            Q   
     /�   DR            S   
     �B  �CT            U   
     \�  DV         
   W   
     \�  9DX                                                                                           	         RSRC