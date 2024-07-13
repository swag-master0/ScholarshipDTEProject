shader_type canvas_item;
//render_mode blend_mix;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;


const int num_colours = 12; // requires manual changing when modifying colours

// Terrible way to do this: each colour has to be inputted manually, with their respective RGB values
const vec3 colour_palette[num_colours] = {
	// Black and White values
	vec3((226.0 / 255.0) , (220.0 / 255.0) , (217.0 / 255.0)),
	vec3((21.0 / 255.0) , (20.0 / 255.0) , (30.0 / 255.0)),
	
	// Red
	vec3((104.0 / 255.0) , (52.0 / 255.0) , (46.0 / 255.0)),
	vec3((188.0 / 255.0) , (98.0 / 255.0) , (86.0 / 255.0)),
	
	// Yellow
	vec3((91.0 / 255.0) , (86.0 / 255.0) , (50.0 / 255.0)),
	vec3((204.0 / 255.0) , (192.0 / 255.0) , (142.0 / 255.0)),
	
	// Green
	vec3((93.0 / 255.0) , (127.0 / 255.0) , (73.0 / 255.0)),
	vec3((171.0 / 255.0) , (196.0 / 255.0) , (157.0 / 255.0)),
	
	// Blue
	vec3((51.0 / 255.0) , (76.0 / 255.0) , (96.0 / 255.0)),
	vec3((163.0 / 255.0) , (182.0 / 255.0) , (198.0 / 255.0)),
	
	// Purple/Pink
	vec3((78.0 / 255.0) , (57.0 / 255.0) , (114.0 / 255.0)),
	vec3((172.0 / 255.0) , (155.0 / 255.0) , (204.0 / 255.0))
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


