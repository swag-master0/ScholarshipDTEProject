shader_type canvas_item;
//render_mode blend_mix;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

// Terrible way to do this: each colour has to be inputted manually, with their respective RGB values.
// However, this method has worked the best out of everything I've tried, and is the most reliable. 

const int num_colours = 14; // requires manual changing when modifying colours

const vec3 colour_palette[num_colours] = {
	// Black and White values
	vec3((0.0 / 255.0) , (7.0 / 255.0) , (12.0 / 255.0)),
	vec3((12.0 / 255.0) , (1.0 / 255.0) , (0.0 / 255.0)),
	vec3((230.0 / 255.0) , (239.0 / 255.0) , (237.0 / 255.0)),
	vec3((242.0 / 255.0) , (233.0 / 255.0) , (227.0 / 255.0)),
	
	// Blue (dark to light)
	vec3((0.0 / 255.0) , (29.0 / 255.0) , (51.0 / 255.0)),
	vec3((21.0 / 255.0) , (71.0 / 255.0) , (107.0 / 255.0)),
	vec3((56.0 / 255.0) , (126.0 / 255.0) , (175.0 / 255.0)),
	vec3((129.0 / 255.0) , (189.0 / 255.0) , (196.0 / 255.0)),
	vec3((164.0 / 255.0) , (216.0 / 255.0) , (212.0 / 255.0)),
	
	// Orange (dark to light)
	vec3((53.0 / 255.0) , (14.0 / 255.0) , (0.0 / 255.0)),
	vec3((99.0 / 255.0) , (42.0 / 255.0) , (13.0 / 255.0)),
	vec3((153.0 / 255.0) , (65.0 / 255.0) , (21.0 / 255.0)),
	vec3((219.0 / 255.0) , (154.0 / 255.0) , (114.0 / 255.0)),
	vec3((239.0 / 255.0) , (207.0 / 255.0) , (182.0 / 255.0))
	
};



void fragment() {
	
	vec3 colour = textureLod(SCREEN_TEXTURE, UV, 0.0).rgb;
	
	float min_colour_diff = 10000.0;
	vec3 closest_colour = vec3(0.0, 0.0, 0.0);
	
	for (int i = 0; i < num_colours; i++) {
		float colour_dist = distance(colour_palette[i], colour);
		
		if (colour_dist < min_colour_diff) {
			min_colour_diff = colour_dist;
			closest_colour = colour_palette[i];
		}
		COLOR.rgb = closest_colour;
	}
}


