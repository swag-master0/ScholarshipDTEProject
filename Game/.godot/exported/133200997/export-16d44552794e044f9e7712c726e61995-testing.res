RSRC                    VisualShader            ��������                                            �      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    input_name    script    op_type 	   operator 	   function 	   constant    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    width    height    use_hdr    fill 
   fill_from    fill_to    repeat    metadata/_snap_enabled    source    texture    texture_type    parameter_name 
   qualifier    hint    min    max    step    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/6/node    nodes/vertex/6/position    nodes/vertex/7/node    nodes/vertex/7/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/19/node    nodes/fragment/19/position    nodes/fragment/23/node    nodes/fragment/23/position    nodes/fragment/24/node    nodes/fragment/24/position    nodes/fragment/25/node    nodes/fragment/25/position    nodes/fragment/27/node    nodes/fragment/27/position    nodes/fragment/28/node    nodes/fragment/28/position    nodes/fragment/29/node    nodes/fragment/29/position    nodes/fragment/30/node    nodes/fragment/30/position    nodes/fragment/31/node    nodes/fragment/31/position    nodes/fragment/33/node    nodes/fragment/33/position    nodes/fragment/34/node    nodes/fragment/34/position    nodes/fragment/35/node    nodes/fragment/35/position    nodes/fragment/36/node    nodes/fragment/36/position    nodes/fragment/37/node    nodes/fragment/37/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        $   local://VisualShaderNodeInput_pqbtt 3      '   local://VisualShaderNodeVectorOp_7hbe0 x      $   local://VisualShaderNodeInput_0qry2 �      ,   local://VisualShaderNodeVectorCompose_hctgb �      $   local://VisualShaderNodeInput_eiaw0        (   local://VisualShaderNodeFloatFunc_0pqb8 W      (   local://VisualShaderNodeFloatFunc_ondai �      (   local://VisualShaderNodeFloatFunc_5n8mu �      &   local://VisualShaderNodeFloatOp_o6o14       ,   local://VisualShaderNodeFloatConstant_tmvo8 Q      &   local://VisualShaderNodeFloatOp_cwqmd �      &   local://VisualShaderNodeFloatOp_1mk54 �      ,   local://VisualShaderNodeFloatConstant_5eyrr #      $   local://VisualShaderNodeInput_y38bs ]         local://Gradient_rw65x �          local://GradientTexture2D_u5q87 �      &   local://VisualShaderNodeTexture_68tk3 C      '   local://VisualShaderNodeVectorOp_s3a54 �      ,   local://VisualShaderNodeFloatConstant_kmalb �      +   local://VisualShaderNodeDistanceFade_13o4y �      (   local://VisualShaderNodeFloatFunc_fcbwg O      $   local://VisualShaderNodeInput_ws03n �      (   local://VisualShaderNodeFloatFunc_jttvr �      &   local://VisualShaderNodeFloatOp_mmg3b �      ,   local://VisualShaderNodeFloatConstant_towvi >      &   local://VisualShaderNodeFloatOp_oikuw x      &   local://VisualShaderNodeFloatOp_unaqx �      -   local://VisualShaderNodeFloatParameter_oq75k �      -   local://VisualShaderNodeFloatParameter_as0wr T         local://VisualShader_0kscs �         VisualShaderNodeInput                       normal          VisualShaderNodeVectorOp             VisualShaderNodeInput                       vertex          VisualShaderNodeVectorCompose                       VisualShaderNodeInput             time          VisualShaderNodeFloatFunc              	                   VisualShaderNodeFloatFunc              	      
            VisualShaderNodeFloatFunc              	                  VisualShaderNodeFloatOp                       VisualShaderNodeFloatConstant    
         ?         VisualShaderNodeFloatOp                                 )   �������?                  VisualShaderNodeFloatOp                      VisualShaderNodeFloatConstant    
        �@         VisualShaderNodeInput             view       	   Gradient                $      q�`?q�`?q�`?  �?  �?  �?  �?  �?         GradientTexture2D                   
      ?  �?   
      ?   ?                  VisualShaderNodeTexture                                  VisualShaderNodeVectorOp                      VisualShaderNodeFloatConstant    
        �@         VisualShaderNodeDistanceFade                          A            A         VisualShaderNodeFloatFunc    	                  VisualShaderNodeInput             time          VisualShaderNodeFloatFunc              	                   VisualShaderNodeFloatOp                                VisualShaderNodeFloatConstant    
        �?         VisualShaderNodeFloatOp             VisualShaderNodeFloatOp                                      �A         VisualShaderNodeFloatParameter             FogIntensity !         "        �@         VisualShaderNodeFloatParameter             FogDistance !         "        �A         VisualShader <   #      c  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D tex_frg_23 : source_color;
uniform float FogIntensity = 5;
uniform float FogDistance = 30;



void fragment() {
// Input:19
	vec3 n_out19p0 = VIEW;


// FloatConstant:25
	float n_out25p0 = 4.000000;


// VectorOp:24
	vec3 n_out24p0 = n_out19p0 * vec3(n_out25p0);


// Texture2D:23
	vec4 n_out23p0 = texture(tex_frg_23, vec2(n_out24p0.xy));


// Input:29
	float n_out29p0 = TIME;


// FloatFunc:30
	float n_out30p0 = sin(n_out29p0);


// FloatConstant:33
	float n_out33p0 = 1.000000;


// FloatOp:34
	float n_out34p0 = n_out30p0 + n_out33p0;


// FloatParameter:36
	float n_out36p0 = FogIntensity;


// FloatOp:31
	float n_out31p0 = n_out34p0 * n_out36p0;


// FloatParameter:37
	float n_out37p0 = FogDistance;


// FloatOp:35
	float n_out35p0 = n_out31p0 + n_out37p0;


// DistanceFade:27
	float n_out27p0 = clamp(smoothstep(n_out35p0, n_out31p0,-VERTEX.z),0.0,1.0);


// FloatFunc:28
	float n_out28p0 = sqrt(n_out27p0);


// Output:0
	ALBEDO = vec3(n_out23p0.xyz);
	ALPHA = n_out28p0;


}
 <   
     �C  C=             >   
     ��  pB?            @   
     ��  4CA            B   
     ��  �CC                                     D   
     �D   CE            F   
    ��D  �DG            H   
     ��  �DI            J   
     �C  �DK            L   
     D  �DM            N   
     4D  �DO            P   
     kD  �DQ         	   R   
     4D ��DS         
   T   
    ��D  �DU            V   
      C  �DW            X   
      �  �DY            Z   
     �C  \�[            \   
     �D  ��]            ^   
     �D  ��_            `   
     CD  p�a            b   
     zD  *Dc            d   
     �D  *De            f   
     4�  Dg            h   
     �B  Di            j   
     D  Dk            l   
     �B  MDm            n   
     �C  Do            p   
     RD  �Cq            r   
     pC  aDs            t   
     �C  �Cu       d   	       
       
                                                                                                       	                                                                     "       "                                  #       #                                          !       "      $             %       #                                        RSRC