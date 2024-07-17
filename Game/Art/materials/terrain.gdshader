shader_type spatial;

const vec3 colour = vec3(0.7, 0.7, 0.9);


void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = colour;
}

