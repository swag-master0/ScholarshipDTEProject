shader_type canvas_item;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;

uniform float outline_alpha = 0.75;


// For Sobel filtering
vec3 convolution(sampler2D tex, vec2 uv, vec2 pixel_size) {
	vec3 conv = vec3(0.0);
	
	// For Gaussian Blurring (see wikipedia page for full mathematics)
	float gauss[25] = {
		0.00390625, 0.015625, 0.0234375, 0.015625, 0.00390625,
		0.015625, 0.0625, 0.09375, 0.0625, 0.015625, 0.0234375,
		0.09375, 0.140625, 0.09375, 0.0234375, 0.015625,
		0.0625, 0.09375, 0.0625, 0.015625, 0.00390625,
		0.015625, 0.0234375, 0.015625, 0.00390625
	};
	
	for (int row = 0; row < 5; row++) {
		for (int col = 0; col < 5; col++) {
			conv += texture(tex, uv + vec2(float(col - 2), float(row - 2)) * pixel_size).rgb * gauss[row * 5 + col];
		}
	}
	return conv;
}


void fragment() {
	
	// SOBEL OPERATOR, for edge detection: https://en.wikipedia.org/wiki/Sobel_operator
	vec3 pixels[9]; 
	// This forms a Matrix
	// [0, 1, 2]
	// [3, 4, 5]
	// [6, 7, 8]
	
	for (int row = 0; row < 3; row++) {
		for (int col = 0; col < 3; col++){
			vec2 uv = SCREEN_UV + vec2(float(col - 1), float(row - 1)) * SCREEN_PIXEL_SIZE;
			pixels[row * 3 + col] = convolution(SCREEN_TEXTURE, uv, SCREEN_PIXEL_SIZE);
		}
	}
	
	
	vec3 gx = (
		pixels[0] * -1.0 + pixels[3] * -2.0 + pixels[6] * -1.0
		+ pixels[2] * 1.0 + pixels[5] * 2.0 + pixels[8] * 1.0
	);
	vec3 gy = (
		pixels[0] * -1.0 + pixels[1] * -2.0 + pixels[2] * -1.0
		+ pixels[6] * 1.0 + pixels[7] * 2.0 + pixels[8] * 1.0
	);
	
	// Raw sobel colour
	vec3 sobel = sqrt(gx * gx + gy * gy);
	
	// Turning the outlines into a single colour
	float grey = round(sobel.r);
	vec4 sobel_color = vec4(grey, grey, grey, 1.0);
	
	// Turning black values into transparent values
	vec4 outlines = vec4(round(sobel_color));
	if (outlines.x == 0.0) {
		outlines.a = 0.0;
	}
	
	// Turn white values into dark outlines
	if (outlines.a > 0.0) {
		outlines.r = 0.0;
		outlines.g = 0.0;
		outlines.b = 0.0;
		outlines.a = outline_alpha;
	}
	
	COLOR = outlines;
	
}

