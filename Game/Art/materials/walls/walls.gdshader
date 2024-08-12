shader_type spatial;
//render_mode diffuse_toon, specular_toon;

const vec3 wall_colour = vec3(2.0, 4.0, 2.0);
uniform sampler2D noise;
uniform sampler2D normal_tex;
uniform float amount = 1.0;

void fragment() {
	vec3 noise_colour = textureLod(noise, UV, 1).rgb;
	
	vec3 colour = mix(wall_colour, noise_colour, 0.5);
	ALBEDO = colour * 4.0 + vec3(1.0, 1.0, 1.5);
	
	NORMAL_MAP = textureLod(normal_tex, UV * amount, 0.25).rgb;
	ROUGHNESS = 1.0;
	
	
}


