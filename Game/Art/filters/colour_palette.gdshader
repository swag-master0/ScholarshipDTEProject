shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

// Terrible way to do this: each colour has to be inputted manually, with their respective RGB values.
// However, this method has worked the best out of everything I've tried, and is the most reliable. 
//const vec3 colour_palette[] = {
//	// Black and White
//	vec3(0.0 , 0.0 , 0.0),
//	vec3(1.0 , 1.0 , 1.0),
//	
//	// Blue (dark to light)
//	vec3((0.0 / 255.0) , (7.0 / 255.0) , (12.0 / 255.0)),
//	vec3((7.0 / 255.0) , (21.0 / 255.0) , (32.0 / 255.0)),
//	vec3((12.0 / 255.0) , (32.0 / 255.0) , (47.0 / 255.0)),
//	vec3((19.0 / 255.0) , (48.0 / 255.0) , (68.0 / 255.0)),
//	vec3((30.0 / 255.0) , (72.0 / 255.0) , (102.0 / 255.0)),
//	vec3((42.0 / 255.0) , (97.0 / 255.0) , (135.0 / 255.0)),
//	vec3((55.0 / 255.0) , (125.0 / 255.0) , (173.0 / 255.0)),
//	vec3((101.0 / 255.0) , (155.0 / 255.0) , (191.0 / 255.0)),
//	vec3((138.0 / 255.0) , (187.0 / 255.0) , (219.0 / 255.0)),
//	vec3((184.0 / 255.0) , (218.0 / 255.0) , (242.0 / 255.0)),
//	vec3((201.0 / 255.0) , (227.0 / 255.0) , (245.0 / 255.0)),
//	vec3((223.0 / 255.0) , (236.0 / 255.0) , (245.0 / 255.0)),
//	vec3((230.0 / 255.0) , (239.0 / 255.0) , (237.0 / 255.0)),
//	
//	// Orange (dark to light)
//	vec3((12.0 / 255.0) , (1.0 / 255.0) , (0.0 / 255.0)),
//	vec3((39.0 / 255.0) , (11.0 / 255.0) , (0.0 / 255.0)),
//	vec3((75.0 / 255.0) , (25.0 / 255.0) , (0.0 / 255.0)),
//	vec3((100.0 / 255.0) , (34.0 / 255.0) , (0.0 / 255.0)),
//	vec3((158.0 / 255.0) , (57.0 / 255.0) , (0.0 / 255.0)),
//	vec3((174.0 / 255.0) , (62.0 / 255.0) , (0.0 / 255.0)),
//	vec3((206.0 / 255.0) , (75.0 / 255.0) , (0.0 / 255.0)),
//	vec3((216.0 / 255.0) , (118.0 / 255.0) , (65.0 / 255.0)),
//	vec3((240.0 / 255.0) , (149.0 / 255.0) , (101.0 / 255.0)),
//	vec3((229.0 / 255.0) , (175.0 / 255.0) , (151.0 / 255.0)),
//	vec3((240.0 / 255.0) , (216.0 / 255.0) , (199.0 / 255.0)),
//	vec3((239.0 / 255.0) , (225.0 / 255.0) , (215.0 / 255.0)),
//	vec3((245.0 / 255.0) , (238.0 / 255.0) , (233.0 / 255.0))
//	
//};

const vec3 colour_palette[] = {
	// Black and White
	vec3(0.0 , 0.0 , 0.0),
	vec3(1.0 , 1.0 , 1.0),
	
	// Blue
	vec3((3.0 / 255.0) , (7.0 / 255.0) , (10.0 / 255.0)),
	vec3((27.0 / 255.0) , (40.0 / 255.0) , (48.0 / 255.0)),
	vec3((43.0 / 255.0) , (61.0 / 255.0) , (75.0 / 255.0)),
	vec3((58.0 / 255.0) , (83.0 / 255.0) , (101.0 / 255.0)),
	vec3((86.0 / 255.0) , (121.0 / 255.0) , (145.0 / 255.0)),
	vec3((141.0 / 255.0) , (164.0 / 255.0) , (179.0 / 255.0)),
	vec3((186.0 / 255.0) , (200.0 / 255.0) , (207.0 / 255.0)),
	vec3((232.0 / 255.0) , (237.0 / 255.0) , (236.0 / 255.0)),
	
	
	// Orange
	vec3((9.0 / 255.0) , (3.0 / 255.0) , (3.0 / 255.0)),
	vec3((52.0 / 255.0) , (29.0 / 255.0) , (17.0 / 255.0)),
	vec3((93.0 / 255.0) , (52.0 / 255.0) , (31.0 / 255.0)),
	vec3((130.0 / 255.0) , (74.0 / 255.0) , (43.0 / 255.0)),
	vec3((156.0 / 255.0) , (92.0 / 255.0) , (55.0 / 255.0)),
	vec3((179.0 / 255.0) , (131.0 / 255.0) , (106.0 / 255.0)),
	vec3((210.0 / 255.0) , (184.0 / 255.0) , (173.0 / 255.0)),
	vec3((233.0 / 255.0) , (222.0 / 255.0) , (221.0 / 255.0)),
	vec3((245.0 / 255.0) , (232.0 / 255.0) , (229.0 / 255.0))
	
	
};

const int num_colours = colour_palette.length();



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
		//COLOR.rgb = vec3(colour_dist, 0.0, 0.0);
	}
}


