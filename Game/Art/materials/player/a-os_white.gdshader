shader_type spatial;
render_mode unshaded;

uniform vec3 colour = vec3(0.1, 0.1, 0.1);

void vertex() {
	VERTEX.y += round(sin(TIME * 5.0 + VERTEX.x * 10.0)) / 30.0;
}

void fragment() {
	ALBEDO = colour;
}

