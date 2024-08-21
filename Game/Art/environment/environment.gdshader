shader_type sky;

uniform sampler2D cloudlayer1;
uniform sampler2D cloudlayer2;



void sky() {
	vec2 sky_uv = (EYEDIR.xz / EYEDIR.y);
	vec3 cloud1 = texture(cloudlayer1, vec2(sky_uv.x + TIME * 0.10, sky_uv.y + TIME * 0.2)).rgb;
	vec3 cloud2 = texture(cloudlayer2, vec2(sky_uv.x + TIME * 0.05, sky_uv.y + TIME * 0.1)).rgb;
	
	vec3 sky = mix(cloud1, cloud2, 0.5);
	
	if (SKY_COORDS.y > 0.5) { 
		sky = vec3(0.05, 0.05, 0.05);
	}
	
	COLOR = sky;
	
}
