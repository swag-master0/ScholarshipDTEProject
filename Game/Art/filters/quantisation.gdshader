shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
const float scale_factor = 15.0;


void fragment() {
	vec4 pic = texture(SCREEN_TEXTURE, UV);
	
	pic.r = round(pic.r * scale_factor) / scale_factor;
	pic.g = round(pic.g * scale_factor) / scale_factor;
	pic.b = round(pic.b * scale_factor) / scale_factor;
	
	COLOR = pic;
	
}

