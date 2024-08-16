shader_type spatial;

uniform sampler2D noise;
uniform sampler2D normal;

void fragment() {
	ALBEDO = texture(noise, UV).rgb;
	NORMAL_MAP = texture(normal, UV).rgb;

}
