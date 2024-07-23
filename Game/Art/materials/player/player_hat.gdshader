shader_type spatial;

uniform sampler2D normal;
const vec3 base_colour = vec3(0.075, 0.025, 0.025);



void vertex() {
	VERTEX.y += round(sin(TIME * 5.0 + VERTEX.x * 10.0)) / 100.0;
}

void fragment() {
	// Called for every pixel the material is visible on.
	NORMAL_MAP = textureLod(normal, UV, 1.0).rgb;
	
	ALBEDO = base_colour;
	
	
}


