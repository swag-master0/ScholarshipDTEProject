shader_type spatial;

uniform sampler2D normal;
uniform vec3 base_colour = vec3(0.8, 0.025, 0.0);


void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = base_colour;
	EMISSION = base_colour / 3.0;
	
	NORMAL_MAP = textureLod(normal, UV, 1.0).rgb;

}
