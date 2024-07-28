shader_type sky;

uniform float quality = 4.0;
uniform sampler2D skyTexture;
const vec3 colour = vec3(1, 0.5, 0);

uniform sampler2D noise1;



void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	vec2 uv = vec2(SKY_COORDS.x, SKY_COORDS.y * 0.85);
	
	vec3 skycolour = textureLod(skyTexture, uv, quality).rgb;
	//vec3 skycolour = textureLod(skyTexture, vec2(SKY_COORDS.x + TIME, SKY_COORDS.y), quality).rgb;
	vec3 mixed_colour = mix(colour, skycolour, 0.75).rgb - vec3(0.4);
	
	//COLOR = mixed_colour;
	
	
	
	
	vec2 sky_uv = (EYEDIR.xz / EYEDIR.y);
	vec2 sky_uv2 = vec2(SKY_COORDS.x + TIME/50.0, SKY_COORDS.y);
	vec2 completeuv = mix(sky_uv, sky_uv2, 0.5);
	
	//vec3 cloud_color = texture(noise1, sky_uv + TIME * 0.05).rgb;
	vec3 cloud_color = texture(noise1, (sky_uv + TIME * 0.05)).rgb;
	
	COLOR = cloud_color;
	
	
	
	
	
	
}
