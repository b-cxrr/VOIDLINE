shader_type canvas_item;

uniform sampler2D screen_texture
	: hint_screen_texture, repeat_disable, filter_nearest;

uniform float intensity : hint_range(0.0, 1.0) = 0.0;
uniform float glitch_time = 0.0;
uniform float rgb_separation : hint_range(0.0, 0.02) = 0.004;
uniform float tear_strength : hint_range(0.0, 0.05) = 0.015;
uniform float scanline_strength : hint_range(0.0, 1.0) = 0.25;


float random_value(float value) {
	return fract(sin(value * 12.9898) * 43758.5453);
}


void fragment() {
	vec2 uv = SCREEN_UV;

	float band = floor(uv.y * 35.0);
	float band_random = random_value(
		band + floor(glitch_time * 25.0)
	);

	float tear = step(0.72, band_random);

	float horizontal_offset =
		(band_random - 0.5)
		* tear_strength
		* tear
		* intensity;

	uv.x += horizontal_offset;

	float rgb_offset = rgb_separation * intensity;

	float red = texture(
		screen_texture,
		uv + vec2(rgb_offset, 0.0)
	).r;

	float green = texture(
		screen_texture,
		uv
	).g;

	float blue = texture(
		screen_texture,
		uv - vec2(rgb_offset, 0.0)
	).b;

	vec3 glitch_colour = vec3(red, green, blue);

	float scanline = sin(SCREEN_UV.y * 900.0);

	float scanline_darkening =
		1.0
		- max(scanline, 0.0)
		* scanline_strength
		* intensity;

	glitch_colour *= scanline_darkening;

	vec3 original_colour = texture(screen_texture, SCREEN_UV).rgb;
vec3 final_colour = mix(original_colour, glitch_colour, intensity);

COLOR = vec4(final_colour, 1.0);
}
