shader_type canvas_item;

uniform sampler2D sky_texture;
uniform float time : hint_range(0.0, 1.0);
uniform float distortion_strength : hint_range(0.0, 1.0) = 0.2;
uniform float noise_scale : hint_range(0.0, 10.0) = 5.0;

float rand (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}
void fragment() {
    // Get texture coordinates
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    
    // Add random noise to the texture coordinates
    float noise = rand(uv * time * noise_scale);
    uv.y += (noise - 0.5) * distortion_strength;
    
    // Sample the sky texture with the distorted coordinates
    vec4 texColor = texture(sky_texture, uv);
    
    // Apply glitching effect: color distortion and stretching
    texColor.rgb += sin(time * 10.0 + uv.x * 100.0) * 0.1;
    
    // Output the modified color
    COLOR = texColor;
}
