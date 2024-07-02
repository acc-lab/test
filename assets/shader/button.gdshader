shader_type canvas_item;

uniform float cd_effect: hint_range(0.0, 1.0) = 0;

uniform float as_if_height = 22;

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	if(floor(UV.y*as_if_height)/as_if_height >= 1.0-cd_effect){
		color.rgb = mix(color.rgb, vec3(0), 0.8);
	}
	COLOR = color;
}