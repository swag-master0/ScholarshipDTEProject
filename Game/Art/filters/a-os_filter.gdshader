shader_type canvas_item;
render_mode unshaded, blend_premul_alpha;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D VIEWPORT_TEXTURE;
const float threshold = 0.5;


void fragment() {
	vec4 colour = texture(VIEWPORT_TEXTURE, UV);
	vec4 roundedcol = round(colour);
	
	
	if (roundedcol.r > threshold) {
		roundedcol = vec4(1.0, 1.0, 1.0, 1.0);
	} else {
		roundedcol = vec4(0.0, 0.0, 0.0, 0.0);
	}
	
	COLOR = roundedcol;
}


