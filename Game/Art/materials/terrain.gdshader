shader_type spatial;

const vec3 colour = vec3(2.5, 2.5, 2.5);


void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = colour;
}

