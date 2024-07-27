shader_type spatial;

const vec3 colormain = vec3(0.1, 0.15, 0.1);
const vec3 colorsec = vec3(0.15, 0.1, 0.1);
uniform sampler2D text;
uniform sampler2D normal;


void fragment() {
	METALLIC = 0.75;
	ROUGHNESS = 0.5;
	
	vec3 text_colour = texture(text, UV).rgb;
	if (text_colour == vec3(1.0, 1.0, 1.0)) {
		text_colour = colormain;
	} else {
		text_colour = colorsec;
	}
	
	ALBEDO = text_colour;
	NORMAL_MAP = texture(normal, UV).rgb;
	
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
