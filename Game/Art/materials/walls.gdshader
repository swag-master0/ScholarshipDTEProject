shader_type spatial;
//render_mode diffuse_toon, specular_toon;

const vec3 wall_colour = vec3(0.8, 0.8, 1.0);
uniform sampler2D noise;
uniform sampler2D normal_tex;

void fragment() {
	vec3 noise_colour = textureLod(noise, UV, 1).rgb;
	
	vec3 colour = mix(wall_colour, noise_colour, 0.5);
	ALBEDO = wall_colour;
	NORMAL_MAP = textureLod(normal_tex, UV, 1).rgb;
	ROUGHNESS = 1.0;
	
	
}


