shader_type spatial;
render_mode unshaded, depth_test_disabled, depth_draw_never, blend_mix;

uniform float fade = 0.1;

void vertex() {
	POSITION = vec4(VERTEX.x, -VERTEX.y, 0.0, 1.0);
}

void fragment() {
	ALBEDO = vec3(0.1, 0.1, 0.1);
	ALPHA = fade;
}
