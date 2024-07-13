shader_type spatial;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec2 uv = SCREEN_UV;
	float y = 1.0 - uv.y;
	
	COLOR = vec4(texture(SCREEN_TEXTURE, vec2(uv.x, y))); 
}

