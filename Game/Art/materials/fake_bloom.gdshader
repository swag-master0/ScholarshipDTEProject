shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
//uniform float threshold = 0;
//uniform float amount = 0.50;


//void fragment() {
//	vec3 colour = texture(SCREEN_TEXTURE, UV).rgb;
//	float brightness = (colour.r + colour.g + colour.b) / 3.0;
//	
//	if (brightness >= threshold) {
//		vec4 blurred_colour = texture(SCREEN_TEXTURE, UV, amount);
//		blurred_colour.a = 255.0;
//		COLOR = blurred_colour;
//	} else {
//		COLOR = vec4(0.0, 0.0, 0.0, 0.0);
//	}
//	
//}


//vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
//	float hdr_threshold = 0.1; // Exagerated, almost everything will glow
//	return max(textureLod(tex, uv, 2.0) - hdr_threshold, vec4(0.0));
//}

//void fragment() {
//	vec2 ps = SCREEN_PIXEL_SIZE;
//	// Get blurred color from pixels considered glowing
//	vec4 col0 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(-ps.x, 0));
//	vec4 col1 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(ps.x, 0));
//	vec4 col2 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(0, -ps.y));
//	vec4 col3 = sample_glow_pixel(SCREEN_TEXTURE, SCREEN_UV + vec2(0, ps.y));
//	
//	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);
//	vec4 glowing_col = 0.25 * (col0 + col1 + col2 + col3);
//	
//	COLOR = vec4(col.rgb + glowing_col.rgb, col.a);
//}
