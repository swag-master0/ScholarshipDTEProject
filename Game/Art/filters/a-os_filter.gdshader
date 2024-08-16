shader_type canvas_item;
render_mode unshaded, blend_premul_alpha;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D VIEWPORT_TEXTURE;
const int pixel_size = 3;



void fragment() {

	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);

	x = FRAGCOORD.x + floor(float(pixel_size) / 2.0) - x;
	y = FRAGCOORD.y + floor(float(pixel_size) / 2.0) - y;


	COLOR = texture(VIEWPORT_TEXTURE, vec2(x, y) / vec2(1.0 / SCREEN_PIXEL_SIZE.x, 1.0 / SCREEN_PIXEL_SIZE.y));
}
