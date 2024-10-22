RSRC                    VisualShader            ��������                                            f      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    linked_parent_graph_frame    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    script    source    texture    input_name    op_type    default_value_enabled    default_value 	   constant 
   port_type    hint    min    max    step 	   operator    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        1   local://VisualShaderNodeTexture2DParameter_vvd6n �      &   local://VisualShaderNodeTexture_o1i3w �      $   local://VisualShaderNodeInput_ho4iq 0      "   local://VisualShaderNodeMix_cg81a e      -   local://VisualShaderNodeColorParameter_5vn1w �      1   local://VisualShaderNodeTexture2DParameter_oqe8g /      &   local://VisualShaderNodeTexture_su2a3 |      ,   local://VisualShaderNodeFloatConstant_t76fl �      ,   local://VisualShaderNodeFloatConstant_osx1m �      &   local://VisualShaderNodeReroute_vja34 $      &   local://VisualShaderNodeReroute_vtsy5 x      &   local://VisualShaderNodeReroute_2n3ef �      -   local://VisualShaderNodeFloatParameter_x2tvu        '   local://VisualShaderNodeVectorOp_wtli8 |      ,   local://VisualShaderNodeFloatConstant_bp5hh �      1   res://Art/materials/walls/walls_underground.tres +      #   VisualShaderNodeTexture2DParameter             ColourTexture 
                           VisualShaderNodeTexture                      VisualShaderNodeInput             uv          VisualShaderNodeMix                                              �?  �?  �?            ?   ?   ?                  VisualShaderNodeColorParameter             BaseColour       #   VisualShaderNodeTexture2DParameter             NormalTexture          VisualShaderNodeTexture                      VisualShaderNodeFloatConstant             ?         VisualShaderNodeFloatConstant             A         VisualShaderNodeReroute                    
                             VisualShaderNodeReroute                    
                             VisualShaderNodeReroute                    
                             VisualShaderNodeFloatParameter          	   UV_Scale                  �?         VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeFloatConstant            �?         VisualShader !         �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform vec4 BaseColour : source_color;
uniform float UV_Scale = 1;
uniform sampler2D ColourTexture : filter_nearest, repeat_enable;
uniform sampler2D NormalTexture;



void fragment() {
// ColorParameter:6
	vec4 n_out6p0 = BaseColour;


// Input:4
	vec2 n_out4p0 = UV;


// FloatParameter:14
	float n_out14p0 = UV_Scale;


// VectorOp:15
	vec2 n_out15p0 = n_out4p0 * vec2(n_out14p0);


// Reroute:13
	vec2 n_out13p0 = n_out15p0;


// Reroute:11
	vec2 n_out11p0 = n_out13p0;


	vec4 n_out3p0;
// Texture2D:3
	n_out3p0 = texture(ColourTexture, n_out11p0);


// FloatConstant:9
	float n_out9p0 = 0.500000;


// Mix:5
	vec3 n_out5p0 = mix(vec3(n_out6p0.xyz), vec3(n_out3p0.xyz), vec3(n_out9p0));


// FloatConstant:16
	float n_out16p0 = 1.000000;


// Reroute:12
	vec2 n_out12p0 = n_out13p0;


	vec4 n_out8p0;
// Texture2D:8
	n_out8p0 = texture(NormalTexture, n_out12p0);


// FloatConstant:10
	float n_out10p0 = 8.000000;


// Output:0
	ALBEDO = n_out5p0;
	ROUGHNESS = n_out16p0;
	NORMAL = vec3(n_out8p0.xyz);
	NORMAL_MAP_DEPTH = n_out10p0;


}
 7             8   
     /�  �C9            :   
     ��  �C;            <   
     ��  �C=            >   
   �R�A:&C?            @   
     ��  �AA            B   
     /�  HDC            D   
     ��  /DE            F   
     ��  �CG            H   
      C  DI         	   J   
     >�  �CK         
   L   
     R�  4DM            N   
     u�  �CO            P   
     ��  DQ            R   
     ��  �CS            T   
     4C  �CU       @                                                                                     	             
           
                                                                                                                        RSRC