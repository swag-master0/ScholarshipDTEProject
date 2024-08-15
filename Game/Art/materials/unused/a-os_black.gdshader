shader_type spatial;
render_mode unshaded;

void vertex() {
	VERTEX.y += round(sin(TIME * 5.0 + VERTEX.x * 10.0)) / 50.0;
}

void fragment() {
	ALBEDO = vec3(0.0, 0.0, 0.0);
}

