RSRC                    VisualShader            ��������                                            �      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    input_name    script 	   function    op_type 	   operator    interpolation_mode    interpolation_color_space    offsets    colors    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    source    texture    texture_type    parameter_name 
   qualifier    default_value_enabled    default_value 
   port_type 	   constant    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/19/node    nodes/fragment/19/position    nodes/fragment/20/node    nodes/fragment/20/position    nodes/fragment/21/node    nodes/fragment/21/position    nodes/fragment/22/node    nodes/fragment/22/position    nodes/fragment/23/node    nodes/fragment/23/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        $   local://VisualShaderNodeInput_c2dgf �      $   local://VisualShaderNodeInput_vnvvm       (   local://VisualShaderNodeFloatFunc_j0pen M      '   local://VisualShaderNodeVectorOp_ahsqp �         local://Gradient_506ip �         local://FastNoiseLite_iem64 %         local://NoiseTexture2D_7lqhq g      &   local://VisualShaderNodeTexture_37bgp �      '   local://VisualShaderNodeVectorOp_xey3x �         local://Gradient_3lrh5          local://FastNoiseLite_c66h4 L         local://NoiseTexture2D_v0m6a j      &   local://VisualShaderNodeTexture_iw2oa �      "   local://VisualShaderNodeMix_5ifeh �      -   local://VisualShaderNodeColorParameter_2d026 q      -   local://VisualShaderNodeColorParameter_osrkm �      &   local://VisualShaderNodeReroute_rpju4 ?      "   local://VisualShaderNodeMix_esjwh �      ,   local://VisualShaderNodeFloatConstant_23ctn       ,   local://VisualShaderNodeFloatConstant_s1d0l M      &   local://VisualShaderNodeFloatOp_ayo8m �         res://Art/materials/water.tres �         VisualShaderNodeInput             uv          VisualShaderNodeInput             time          VisualShaderNodeFloatFunc                      VisualShaderNodeVectorOp                    
                 
           	                	   Gradient                !          �0�>         FastNoiseLite                   ��L=                  NoiseTexture2D    $         %         .            /                     VisualShaderNodeTexture    1                     VisualShaderNodeVectorOp          	   Gradient       !          �RR?         FastNoiseLite             NoiseTexture2D    .         	   /         
            VisualShaderNodeTexture    1                     VisualShaderNodeMix                                                  �?  �?  �?  �?            ?   ?   ?   ?	                  VisualShaderNodeColorParameter    3         Colour1 5         6        �?  �>  �>  �?         VisualShaderNodeColorParameter    3         Colour2 5         6      ��>uV�=}?U>  �?         VisualShaderNodeReroute                    2                   7                  VisualShaderNodeMix                                                                    ?   ?   ?	                  VisualShaderNodeFloatConstant             VisualShaderNodeFloatConstant    8         @         VisualShaderNodeFloatOp                                 )   {�G�z�?
                  VisualShader !   9      �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 Colour1 : source_color = vec4(1.000000, 0.250000, 0.250000, 1.000000);
uniform vec4 Colour2 : source_color = vec4(0.360383, 0.114911, 0.208250, 1.000000);
uniform sampler2D tex_frg_14;
uniform sampler2D tex_frg_12;



void fragment() {
// ColorParameter:16
	vec4 n_out16p0 = Colour1;


// ColorParameter:17
	vec4 n_out17p0 = Colour2;


// Input:9
	float n_out9p0 = TIME;


// FloatOp:23
	float n_in23p1 = 0.01000;
	float n_out23p0 = n_out9p0 * n_in23p1;


// FloatFunc:10
	float n_out10p0 = sqrt(n_out23p0);


// Input:5
	vec2 n_out5p0 = UV;


// Texture2D:14
	vec4 n_out14p0 = texture(tex_frg_14, UV);


// VectorOp:13
	vec3 n_out13p0 = vec3(n_out5p0, 0.0) + vec3(n_out14p0.xyz);


// VectorOp:11
	vec2 n_out11p0 = vec2(n_out10p0) + vec2(n_out13p0.xy);


// Texture2D:12
	vec4 n_out12p0 = texture(tex_frg_12, n_out11p0);


// Mix:15
	vec4 n_out15p0 = mix(n_out16p0, n_out17p0, n_out12p0);


// FloatConstant:21
	float n_out21p0 = 0.000000;


// FloatConstant:22
	float n_out22p0 = 2.000000;


// Reroute:19
	vec4 n_out19p0 = n_out12p0;


// Mix:20
	vec3 n_in20p0 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_out20p0 = mix(n_in20p0, vec3(n_out15p0.xyz), vec3(n_out19p0.xyz));


// Output:0
	ALBEDO = vec3(n_out15p0.xyz);
	ROUGHNESS = n_out21p0;
	SPECULAR = n_out22p0;
	EMISSION = n_out20p0;
	NORMAL_MAP = n_out20p0;


}
 U             V   
     ��  �CW            X   
     ��  HCY            Z   
     ��  HC[            \   
     ��  HC]            ^   
     f�  HC_            `   
     ��  �Ca            b   
     ��  �Cc            d   
     \�  Ce            f   
      �  ��g            h   
      �  ��i            j   
     ��  �Ck            l   
     pB  �Cm            n   
     pB  �Co            p   
     pB  �Cq            r   
     ��  4Cs       H   
                                                                                                                                                                              	                                             	                     
             RSRC