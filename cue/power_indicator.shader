shader_type spatial;
render_mode unshaded;
// We don't need disabled depth test because cue is angled if it's inside table.

uniform sampler2D indicator : hint_albedo;
uniform float power = 0.5;
uniform float time = 0.0; // Use own time to control speed

void fragment(){
	vec4 color = texture(indicator, UV);
	ALBEDO = color.rgb;
	
	float power_inv = 1.0 - power;
	
	float h = time + UV.x * 0.3;
	float amount = sin(h * 37.0) * 0.3 + sin(h * 27.0) * 0.4 + sin(h * 11.0) * 0.3 + sin(h * 3.0) * 0.2;
	amount *= 0.4;
	
	float x_power = sin(amount) * 0.1 + (power_inv);
	// Come up with better equation that goes to zero at top
	float x = atan((UV.y - x_power) * 100.0) * (1.0 / 3.14) + 0.5;
	ALPHA = mix(color.a * 0.5, color.a, x);
	//ALPHA_SCISSOR = 0.5;
}