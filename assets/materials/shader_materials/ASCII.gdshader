shader_type spatial;

uniform sampler2D main_tex : source_color;

uniform vec3 luminance_weights = vec3(0.299, 0.587, 0.114);

float luminance(vec3 color) {
    return dot(color, luminance_weights);
}

void fragment() {
    vec2 uv = UV;
    vec3 color = clamp(texture(main_tex, uv).rgb, 0.0, 1.0);
    float lum = luminance(color);

    // Color RGB + luminancia en canal alpha
    vec4 packed = vec4(color, lum);

    // Lo mostramos como output: color + alpha visible (debug visual)
    ALBEDO = packed.rgb;
    ALPHA = packed.a;
}