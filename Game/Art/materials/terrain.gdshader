shader_type spatial;

const vec3 colour = vec3(2.0, 2.5, 2.0);


void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = colour * 2.0;
}
