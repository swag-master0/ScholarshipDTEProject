shader_type spatial;

uniform sampler2D picture;
uniform float emission_strength = 0.2;

void fragment() {
	vec3 image = textureLod(picture, UV, 1.0).rgb;
	ALBEDO = image;
	EMISSION = image * emission_strength;
}

