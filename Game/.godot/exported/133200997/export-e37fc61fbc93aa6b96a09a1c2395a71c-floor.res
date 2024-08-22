RSRC                    Shader            ��������                                                  resource_local_to_scene    resource_name    code    script        %   res://Art/materials/floor/floor.tres �          Shader          �   shader_type spatial;

const vec3 colour = vec3(1.0, 1.75, 1.0);
uniform sampler2D normal;
uniform float uv_scale = 1.0;


void fragment() {
	NORMAL_MAP = textureLod(normal, UV * uv_scale, 0.25).rgb;

	ALBEDO = colour;


	ROUGHNESS = 1.0;
}
       RSRC