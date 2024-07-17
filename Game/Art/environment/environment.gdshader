shader_type sky;

uniform float quality = 4.0;
uniform sampler2D skyTexture;
const vec3 colour = vec3(1, 0.5, 0);

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	vec2 uv = vec2(SKY_COORDS.x, SKY_COORDS.y * 0.85);
	
	vec3 skycolour = textureLod(skyTexture, uv, quality).rgb;
	vec3 mixed_colour = mix(colour, skycolour, 0.75).rgb - vec3(0.4);
	
	COLOR = mixed_colour;
	
}
