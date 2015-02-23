#pragma STDGL invariant(all)	//delete after testing
#define CLIPS_MAX 		8
	#extension GL_ARB_texture_rectangle : enable
	uniform vec4 gfDiffuseColor; 
    uniform vec4 gfSpecularColor; 
	uniform vec4 gfEmissionColor;
    uniform float gfShininess; 
	uniform int gfNumLights;
	uniform int isYUV;
    uniform vec4 gfLightPosition; 
    uniform vec4 gfLightDiffuse;
    uniform vec4 gfLightSpecular;
	uniform int gfNumTextures;
	
	//test
	uniform sampler2DRect y_plane;
	uniform sampler2DRect u_plane;
	uniform sampler2DRect v_plane;
	uniform float width;
	uniform float height;
	uniform float alpha;
	//const float width=128.0;
	//const float height=128.0;
	//const float alpha=1.0;
	const vec3 offset = vec3(-0.0625, -0.5, -0.5);
	const vec3 R_mul = vec3(1.164,  0.000,  1.596);
	const vec3 G_mul = vec3(1.164, -0.391, -0.813);
	const vec3 B_mul = vec3(1.164,  2.018,  0.000);

	varying vec3 gfEyeCoordNormal;
	varying vec4 gfAmbientAndEmission;
	varying vec3 lightVector;
	varying vec3 halfVector;
	
	uniform vec4 clipPlane[CLIPS_MAX];
	uniform bool clipActive[CLIPS_MAX];
	varying float clipDistance[CLIPS_MAX];
	uniform bool hasClip;

	//test
	varying vec2 TexCoord;
	
	void main() {
		vec2 texc;	//texturing
		vec3 yuv, rgb;	//texturing
		vec4 fragColor = vec4(0.0, 0.0, 0.0, 1.0);	//output
	
	if(hasClip){
		for(int i=0;i<CLIPS_MAX;i++){
			if(clipDistance[i]<0.0) discard;
		}
	}
		fragColor = gfAmbientAndEmission;
		if (gfNumLights > 0){ 
			if (gfLightPosition.w == 0.0) {
				vec3 lv = normalize(lightVector);
				vec3 norm = normalize(gfEyeCoordNormal);
				float l_cos = max(0.0, dot(norm, lv) );
				float h_cos = dot(lv, normalize(halfVector));
				fragColor = (gfLightDiffuse * gfDiffuseColor) * l_cos;
				if (h_cos > 0.0) {
					fragColor += (gfSpecularColor * gfLightSpecular) * pow(h_cos, gfShininess);
				}
			}
			fragColor.a = gfDiffuseColor.a;
		}
		fragColor = clamp(fragColor, 0.0, 1.0);
		
		if(isYUV==1){
		texc = TexCoord.st;
		texc.x *= width;
		texc.y *= height;
		yuv.x = texture2DRect(y_plane, texc).r;
		texc.x /= 2.0;
		texc.y /= 2.0;
		yuv.y = texture2DRect(u_plane, texc).r;
		yuv.z = texture2DRect(v_plane, texc).r;
		yuv += offset;
	    rgb.r = dot(yuv, R_mul);
	    rgb.g = dot(yuv, G_mul);
	    rgb.b = dot(yuv, B_mul);
		fragColor = vec4(rgb, alpha);
			}else if(gfNumTextures>0){
				if(gfNumLights>0){	//apply lighting to texture
					fragColor *= texture2DRect(y_plane, TexCoord);
				}else{
					fragColor = texture2DRect(y_plane, TexCoord);
				}
			}

			gl_FragColor = fragColor;
	}