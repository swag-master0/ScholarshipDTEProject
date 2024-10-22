RSRC                    VisualShader            ��������                                            s      resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    metadata/_preview_in_3d_space_    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    output_port_for_preview    default_input_values    expanded_output_ports    source    texture    texture_type    input_name    op_type 	   operator    parameter_name 
   qualifier    hint    min    max    step    default_value_enabled    default_value    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections     
      local://Gradient_2usxy �         local://FastNoiseLite_3erfx �         local://NoiseTexture2D_uiryc #      &   local://VisualShaderNodeTexture_05rwf �      $   local://VisualShaderNodeInput_8twvc �      $   local://VisualShaderNodeInput_d51yy       '   local://VisualShaderNodeVectorOp_akb2x B      &   local://VisualShaderNodeFloatOp_ooiko k      -   local://VisualShaderNodeFloatParameter_5xhxb �         local://VisualShader_n36g4 (      	   Gradient                !      ��>�Pr?   $                    �?$?�~�=;�3>  �?         FastNoiseLite                               NoiseTexture2D                                "         '             (                     VisualShaderNodeTexture    -            .                  VisualShaderNodeInput    /         uv          VisualShaderNodeInput    /         time          VisualShaderNodeVectorOp             VisualShaderNodeFloatOp    *                                   A1                  VisualShaderNodeFloatParameter    2      
   TimeScale 8         9        �?         VisualShader    :      b  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform float TimeScale = 1;
uniform sampler2D tex_frg_4 : source_color;



void fragment() {
// Input:5
	vec2 n_out5p0 = UV;


// Input:7
	float n_out7p0 = TIME;


// FloatParameter:10
	float n_out10p0 = TimeScale;


// FloatOp:9
	float n_out9p0 = n_out7p0 / n_out10p0;


// VectorOp:8
	vec3 n_out8p0 = vec3(n_out5p0, 0.0) + vec3(n_out9p0);


// Texture2D:4
	vec4 n_out4p0 = texture(tex_frg_4, vec2(n_out8p0.xy));


// Output:0
	ALBEDO = vec3(n_out4p0.xyz);
	EMISSION = vec3(n_out4p0.xyz);


}
 U   
     �C  CV            W   
     �B  CX            Y   
     ��  CZ            [   
     %�  pC\            ]   
     ��  C^            _   
     ��  pC`            a   
      �  �Cb                                              	                     	                           
       	            RSRC