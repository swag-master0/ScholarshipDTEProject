shader_type sky;

uniform float quality = 4.0;
uniform sampler2D skyTexture;
const vec3 colour = vec3(1, 0.5, 0);

uniform sampler2D cloudlayer1;
uniform sampler2D cloudlayer2;



void sky() {
	vec2 sky_uv = (EYEDIR.xz / EYEDIR.y);
	
	//vec3 cloud_color = texture(noise1, sky_uv + TIME * 0.05).rgb;
	//vec3 cloud_color1 = texture(cloudlayer1, vec2(sky_uv.x + TIME * 0.025, sky_uv.y + TIME * 0.05)).rgb;
	//vec3 cloud_color2 = texture(cloudlayer2, vec2(sky_uv.x + TIME * 0.05, sky_uv.y + TIME * 0.1)).rgb;
	vec2 uv = vec2(SKY_COORDS.x, SKY_COORDS.y - TIME / 100.0);
	
	vec3 cloud_color1 = texture(cloudlayer1, uv * 4.0).rgb;
	vec3 cloud_color2 = texture(cloudlayer2, vec2(sky_uv.x + TIME * 0.05, sky_uv.y + TIME * 0.1)).rgb;
	
	
	vec3 clouds = mix(cloud_color1, cloud_color2, 0.5);
	
	
	if (SKY_COORDS.y > 0.5) { 
		clouds = vec3(0.25, 0.25, 0.25);
	}
	
	COLOR = clouds;
	
	
	
	
	
	
}
