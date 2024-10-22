RSRC                    VisualShader            ��������                                            }      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    metadata/_preview_in_3d_space_    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    source    texture    texture_type    op_type 	   operator    input_name 
   port_type    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/18/node    nodes/fragment/18/position    nodes/fragment/19/node    nodes/fragment/19/position    nodes/fragment/20/node    nodes/fragment/20/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections           local://Gradient_2usxy �         local://FastNoiseLite_3erfx          local://NoiseTexture2D_uiryc g      &   local://VisualShaderNodeTexture_05rwf �      '   local://VisualShaderNodeVectorOp_akb2x       &   local://VisualShaderNodeFloatOp_hswmq �         local://Gradient_lgm0l �         local://FastNoiseLite_3iku6           local://NoiseTexture2D_gwdvt       &   local://VisualShaderNodeTexture_jy0db ]      '   local://VisualShaderNodeVectorOp_sn426 �      $   local://VisualShaderNodeInput_vh5wr �      $   local://VisualShaderNodeInput_t6uv5 �      &   local://VisualShaderNodeFloatOp_frmb5 *      '   local://VisualShaderNodeVectorOp_gquws �      &   local://VisualShaderNodeReroute_hm7ao �      &   local://VisualShaderNodeReroute_ihfqw       &   local://VisualShaderNodeReroute_dh6yr s      &   local://VisualShaderNodeReroute_xv0mr �         local://Gradient_vu75w �         local://FastNoiseLite_flku4 @         local://NoiseTexture2D_odc2u �      &   local://VisualShaderNodeTexture_j2mmw !      #   res://Art/materials/main_menu.tres e      	   Gradient                !          �/�>�<?   $      iRJ=xZc=ש�=  �?��>��0=�J=  �?@�?���=Y�;>  �?         FastNoiseLite             	      ;pN<                                     NoiseTexture2D                                #          '             (                     VisualShaderNodeTexture    .            /                  VisualShaderNodeVectorOp    *                
                 
           0                   VisualShaderNodeFloatOp    *                             )   ��������1               	   Gradient             FastNoiseLite             NoiseTexture2D    '            (                     VisualShaderNodeTexture    .                     VisualShaderNodeVectorOp             VisualShaderNodeInput    2         time          VisualShaderNodeInput    2         uv          VisualShaderNodeFloatOp    *                             )   {�G�zt?1                  VisualShaderNodeVectorOp    *                
                 
           0                   VisualShaderNodeReroute             VisualShaderNodeReroute    *                
           3                  VisualShaderNodeReroute    *                
           3                  VisualShaderNodeReroute          	   Gradient                $      iRJ=xZc=ש�=  �?  �?  �?  �?  �?         FastNoiseLite             	      ;pN<                                     NoiseTexture2D 	                               #          $         %        �B'            (                     VisualShaderNodeTexture    .            /                  VisualShader     4      �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_10;
uniform sampler2D tex_frg_4 : source_color;
uniform sampler2D tex_frg_20 : source_color;



void fragment() {
// Input:13
	vec2 n_out13p0 = UV;


// Reroute:18
	vec2 n_out18p0 = n_out13p0;


// Input:12
	float n_out12p0 = TIME;


// Reroute:19
	float n_out19p0 = n_out12p0;


// FloatOp:9
	float n_in9p1 = -0.10000;
	float n_out9p0 = n_out19p0 * n_in9p1;


// VectorOp:8
	vec2 n_out8p0 = n_out18p0 + vec2(n_out9p0);


// Reroute:17
	vec2 n_out17p0 = n_out13p0;


// Reroute:16
	float n_out16p0 = n_out12p0;


// FloatOp:14
	float n_in14p1 = 0.00500;
	float n_out14p0 = n_out16p0 * n_in14p1;


// VectorOp:11
	vec3 n_out11p0 = vec3(n_out17p0, 0.0) + vec3(n_out14p0);


// Texture2D:10
	vec4 n_out10p0 = texture(tex_frg_10, vec2(n_out11p0.xy));


// VectorOp:15
	vec2 n_out15p0 = n_out8p0 + vec2(n_out10p0.xy);


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, n_out15p0);


// Texture2D:20
	vec4 n_out20p0 = texture(tex_frg_20, n_out15p0);


// Output:0
	ALBEDO = vec3(n_out4p0.xyz);
	EMISSION = vec3(n_out4p0.xyz);
	NORMAL_MAP = vec3(n_out20p0.xyz);


}
 O   
     D  CP            Q   
     �B  CR            S   
     ��  CT            U   
     �  pCV         	   W   
   o��Í7�CX         
   Y   
     �  �CZ            [   
    ���  �C\            ]   
     ��  pC^            _   
     R�  D`            a   
     ��  �Cb            c   
     z�  Dd            e   
     a�  �Cf            g   
     �  �Bh            i   
     9�  �Cj            k   
     �B  �Cl       H   	                                 
                                   
                                                                                                        	                                                                           	         RSRC