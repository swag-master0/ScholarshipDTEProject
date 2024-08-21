shader_type spatial;

uniform sampler2D normal;
uniform vec3 base_colour = vec3(0.075, 0.025, 0.025);



void fragment() {
	ALBEDO = base_colour;
	NORMAL_MAP = textureLod(normal, UV, 1.0).rgb;
}
