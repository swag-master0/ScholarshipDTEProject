shader_type spatial;

uniform sampler2D picture;

void fragment() {
	ALBEDO = textureLod(picture, UV, 1.0).rgb;
}

