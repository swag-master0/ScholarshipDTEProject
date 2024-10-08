RSRC                    VisualShader            ��������                                            |      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame 	   constant    script    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    source    texture    texture_type    input_name    op_type 	   operator 	   function 
   port_type    parameter_name 
   qualifier    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        ,   local://VisualShaderNodeFloatConstant_r8oku (         local://Gradient_kbvs5 b         local://FastNoiseLite_dpq7x �         local://NoiseTexture2D_jx3rk �      &   local://VisualShaderNodeTexture_pnsjq       $   local://VisualShaderNodeInput_nqfab H      '   local://VisualShaderNodeVectorOp_er87k }         local://Gradient_obxy6 �         local://FastNoiseLite_lcshr �         local://NoiseTexture2D_nbn8n       &   local://VisualShaderNodeTexture_uo7m4 h      (   local://VisualShaderNodeColorFunc_1p53s �      "   local://VisualShaderNodeMix_agash �      &   local://VisualShaderNodeReroute_8lje2 Z      -   local://VisualShaderNodeColorParameter_gndep �      &   local://VisualShaderNodeColorOp_5uu2n       ,   local://VisualShaderNodeFloatConstant_372uq P      $   res://Art/materials/props/wood.tres �         VisualShaderNodeFloatConstant            �?      	   Gradient       $      ��8��8��8  �?���>���>���>  �?         FastNoiseLite          _<         NoiseTexture2D    +            ,                     VisualShaderNodeTexture    .                     VisualShaderNodeInput    0         uv          VisualShaderNodeVectorOp                    
                 
           1                	   Gradient             FastNoiseLite             NoiseTexture2D    (         +            ,                     VisualShaderNodeTexture    .         	            VisualShaderNodeColorFunc                       VisualShaderNodeMix                                              �?  �?  �?            ?   ?   ?1                  VisualShaderNodeReroute                    2                   4                  VisualShaderNodeColorParameter    5         Colour 7         8      |`s?Z�:?#�?  �?         VisualShaderNodeColorOp    2                  VisualShaderNodeFloatConstant          ��?         VisualShader    9      \  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_6;
uniform sampler2D tex_frg_3;
uniform vec4 Colour : source_color = vec4(0.950691, 0.728582, 0.608370, 1.000000);



void fragment() {
// Input:4
	vec2 n_out4p0 = UV;


// Texture2D:6
	vec4 n_out6p0 = texture(tex_frg_6, n_out4p0);


// VectorOp:5
	vec2 n_out5p0 = n_out4p0 + vec2(n_out6p0.xy);


// Texture2D:3
	vec4 n_out3p0 = texture(tex_frg_3, n_out5p0);


	vec3 n_out7p0;
// ColorFunc:7
	{
		vec3 c = vec3(n_out3p0.xyz);
		float max1 = max(c.r, c.g);
		float max2 = max(max1, c.b);
		n_out7p0 = vec3(max2, max2, max2);
	}


// ColorParameter:10
	vec4 n_out10p0 = Colour;


	vec3 n_out11p0;
// ColorOp:11
	{
		float base = n_out7p0.x;
		float blend = vec3(n_out10p0.xyz).x;
		if (base < 0.5) {
			n_out11p0.x = 2.0 * base * blend;
		} else {
			n_out11p0.x = 1.0 - 2.0 * (1.0 - blend) * (1.0 - base);
		}
	}
	{
		float base = n_out7p0.y;
		float blend = vec3(n_out10p0.xyz).y;
		if (base < 0.5) {
			n_out11p0.y = 2.0 * base * blend;
		} else {
			n_out11p0.y = 1.0 - 2.0 * (1.0 - blend) * (1.0 - base);
		}
	}
	{
		float base = n_out7p0.z;
		float blend = vec3(n_out10p0.xyz).z;
		if (base < 0.5) {
			n_out11p0.z = 2.0 * base * blend;
		} else {
			n_out11p0.z = 1.0 - 2.0 * (1.0 - blend) * (1.0 - base);
		}
	}


// FloatConstant:2
	float n_out2p0 = 1.000000;


// Reroute:9
	vec4 n_out9p0 = n_out3p0;


// FloatConstant:12
	float n_out12p0 = 0.600000;


// Output:0
	ALBEDO = n_out11p0;
	ROUGHNESS = n_out2p0;
	NORMAL_MAP = vec3(n_out9p0.xyz);
	NORMAL_MAP_DEPTH = n_out12p0;


}
 T   
     D   CU             V   
     �C  �CW            X   
     p�  4CY            Z   
     ��  HC[            \   
     ��   C]         
   ^   
     9�  �C_            `   
          Ca            b   
     �C  �Bc            d   
         �Ce            f   
      �  ��g            h   
     �C  p�i            j   
     �C  Dk       4                                                                                             	       	           	   
                                           
                        
         RSRC