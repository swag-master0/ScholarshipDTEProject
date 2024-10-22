RSRC                    VisualShader            ��������                                            M      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    op_type    script    parameter_name 
   qualifier    hint    min    max    step    default_value_enabled    default_value 	   operator 	   constant 	   function    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        ,   local://VisualShaderNodeVectorCompose_uicwl f	      -   local://VisualShaderNodeFloatParameter_r6l26 �	      &   local://VisualShaderNodeFloatOp_p5xey �	      ,   local://VisualShaderNodeFloatConstant_njf56 B
      &   local://VisualShaderNodeFloatOp_45ex7 |
      &   local://VisualShaderNodeFloatOp_he3ic �
      (   local://VisualShaderNodeFloatFunc_iqbrh <         local://VisualShader_kxt04 r         VisualShaderNodeVectorCompose             VisualShaderNodeFloatParameter             health                   VisualShaderNodeFloatOp                         �?                               VisualShaderNodeFloatConstant            �?         VisualShaderNodeFloatOp                                      �@                  VisualShaderNodeFloatOp                                      �@                  VisualShaderNodeFloatFunc                      VisualShader          �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform float health = 0;



void fragment() {
// FloatConstant:5
	float n_out5p0 = 1.000000;


// FloatParameter:3
	float n_out3p0 = health;


// FloatOp:6
	float n_in6p1 = 5.00000;
	float n_out6p0 = n_out3p0 * n_in6p1;


// FloatFunc:8
	float n_out8p0 = round(n_out6p0);


// FloatOp:7
	float n_in7p1 = 5.00000;
	float n_out7p0 = n_out8p0 / n_in7p1;


// FloatOp:4
	float n_in4p0 = 1.00000;
	float n_out4p0 = n_in4p0 - n_out7p0;


// VectorCompose:2
	vec3 n_out2p0 = vec3(n_out5p0, n_out4p0, n_out4p0);


// Output:0
	ALBEDO = n_out2p0;


}
 .             /   
     HC  C0            1   
     \�  pC2            3   
     �A  pC4            5   
         C6            7   
     �  �C8            9   
     4�  �C:            ;   
     ��  �C<                                                                                                                               RSRC