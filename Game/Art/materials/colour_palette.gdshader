shader_type canvas_item;
//render_mode blend_mix;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

uniform sampler2D palette: hint_default_black;
uniform int num_colours : hint_range(2, 64) = 8; 
// hint_range limits the max and min values you can assign this in the inspector


vec3 palette_limiter(in vec3 albedo) {
	float estimation_cutoff = 0.001;
	vec3 closest_colour;
	float min_dist = 2.0;
	float n = float(num_colours);
	
	for (int i = 0; i < num_colours; i++) {
		float index = 1.0 / (2.0 * n) + float(i) / n;
		vec3 index_colour = texture(palette, vec2(index, 0.5)).rgb;
		float dist = length(index_colour - albedo);
		
		if (dist < min_dist) {
			min_dist = dist;
			closest_colour = index_colour;
			
			if (min_dist < estimation_cutoff) {
				return closest_colour;
				
			}
		}
	}
	
	return closest_colour;
	
}


void fragment() {
	COLOR.rgb = palette_limiter(texture(SCREEN_TEXTURE, UV).rgb);
	
}


