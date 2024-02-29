//Shader code by Code It All -> https://www.youtube.com/watch?v=CNE7EOVlYLY 

shader_type spatial;
uniform vec3 water_color : source_color;
uniform float uv_scale :hint_range(0.0, 1000.0, 0.1) = 1;
uniform sampler2D water_normal_noise;
uniform float time_scale : hint_range(0.0,10.0,0.05) = 1.0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform sampler2D sun_highlights;
uniform float color_ratio : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform vec2 abberration_r;
uniform vec2 abberration_g;
uniform vec2 abberration_b;

uniform float highlights_time_scale = 1.0;

uniform float normal : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float roughness :hint_range(0.0, 1.0, 0.1) = 0.25;

vec3 soft_light(vec3 base, vec3 blend) {
    return mix(
        sqrt(base) * (2.0 * blend - 1.0) + 2.0 * base * (1.0 - blend), 
        2.0 * base * blend + base * base * (1.0 - 2.0 * blend), 
        step(base, vec3(0.5))
    );
}
void fragment() {
	
	vec2 _uv = UV * uv_scale;
	vec2 _suv = SCREEN_UV;
	_uv.x += sin(TIME * time_scale + (_uv.x + _uv.y)* 25.0) * 0.01;
	_uv.y += cos(TIME * time_scale + (_uv.x - _uv.y)* 25.0) * 0.01;
	
	_suv.x += sin(TIME * time_scale + (_suv.x + _suv.y)* 25.0) * 0.003;
	_suv.y += cos(TIME * time_scale + (_suv.x - _suv.y)* 25.0) * 0.003;
	
	float r = texture(sun_highlights,_uv+abberration_r+TIME*highlights_time_scale).r;
	float g = texture(sun_highlights,_uv+abberration_g+TIME*highlights_time_scale).g;
	float b = texture(sun_highlights,_uv+abberration_b+TIME*highlights_time_scale).b;
	
	vec3 blended = soft_light(texture(screen_texture,_suv).rgb,vec3(r,g,b));
	
	ALBEDO = mix(blended,water_color,color_ratio);
	NORMAL_MAP = texture(water_normal_noise,_uv).rgb;
	NORMAL *= normal;
	ROUGHNESS = roughness;
	ALPHA = 0.4;
}