RSRC                    VisualShader            ��������                                            C      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    input_name    script    op_type 	   operator 	   constant    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/4/node    nodes/vertex/4/position    nodes/vertex/6/node    nodes/vertex/6/position    nodes/vertex/7/node    nodes/vertex/7/position    nodes/vertex/8/node    nodes/vertex/8/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        $   local://VisualShaderNodeInput_chh45 p      '   local://VisualShaderNodeVectorOp_gy3ox �      '   local://VisualShaderNodeVectorOp_76d0w �      ,   local://VisualShaderNodeFloatConstant_b56tn 	      $   local://VisualShaderNodeInput_fjtfv A	      ,   local://VisualShaderNodeColorConstant_yh1ap z	         local://VisualShader_dob3f �	         VisualShaderNodeInput             normal          VisualShaderNodeVectorOp                      VisualShaderNodeVectorOp             VisualShaderNodeFloatConstant    	      ���=         VisualShaderNodeInput             vertex          VisualShaderNodeColorConstant              	                    �?         VisualShader    
      .  shader_type spatial;
render_mode blend_mix, depth_draw_never, cull_front, diffuse_lambert, specular_schlick_ggx;




void vertex() {
// Input:2
	vec3 n_out2p0 = NORMAL;


// FloatConstant:7
	float n_out7p0 = 0.100000;


// VectorOp:4
	vec3 n_out4p0 = n_out2p0 * vec3(n_out7p0);


// Input:8
	vec3 n_out8p0 = VERTEX;


// VectorOp:6
	vec3 n_out6p0 = n_out4p0 + n_out8p0;


// Output:0
	VERTEX = n_out6p0;


}

void fragment() {
// ColorConstant:2
	vec4 n_out2p0 = vec4(0.000000, 0.000000, 0.000000, 1.000000);


// Output:0
	ALBEDO = vec3(n_out2p0.xyz);


}
                   $             %   
     ��  HC&            '   
     ��  HC(            )   
     �B  pC*            +   
     ��  �C,            -   
     ��  �C.                                                                               0            1   
      C   C2                               RSRC