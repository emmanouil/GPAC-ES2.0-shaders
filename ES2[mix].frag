#pragma STDGL invariant(all)	//delete after testing
#define CLIPS_MAX 		8
#define LIGHTS_MAX 		8

struct gfLight{
	int type;
	vec4 position;
	vec4 direction;
	vec3 attenuation;
	vec4 color;
	float ambientIntensity;
	float intensity;
	float beamWidth;
	float cutOffAngle;
};


uniform vec4 gfDiffuseColor; 
uniform vec4 gfSpecularColor; 
uniform vec4 gfEmissionColor;
uniform float gfShininess; 
uniform int gfNumLights;
uniform int isYUV;
uniform vec4 gfLightPosition; 
uniform vec4 gfLightDiffuse;
uniform vec4 gfLightAmbient; 
uniform vec4 gfLightSpecular;
uniform int gfNumTextures;
uniform gfLight lights[LIGHTS_MAX];
uniform bool hasClip;
uniform bool hasMeshColour;
uniform bool enableLights;

//test
uniform sampler2D y_plane;
uniform sampler2D u_plane;
uniform sampler2D v_plane;
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
varying vec4 gfEye;
varying vec4 gfAmbientAndEmission;
varying vec4 gfDiffuseFactor;
//varying vec3 lightVector;
//varying vec3 halfVector;
varying vec2 TexCoord;
varying vec3 lightVector[8];
varying vec3 halfVector[8];
varying float clipDistance[CLIPS_MAX];

//testing material
varying vec4 m_ambientC;
varying vec4 m_diffuseC;
varying vec4 m_specularC;
varying vec4 m_emissionC;
varying float m_shininess;	//a.ka. specular exponent
varying vec4 m_colour;
//+ uniform bool hasMeshColour;

const float zero_float = 0.0;
const float one_float = 1.0;


vec4 doLighting(int i){

	//instead of vec4 lightColor = gfAmbientAndEmission;
	vec4 lightColor = vec4(zero_float, zero_float, zero_float, zero_float);

	vec3 lightDirection = vec3(lights[i].position-gfEye);
	//check the way position & direction are handled according to type
	if(lights[i].type == 0)
		lightDirection = vec3(lights[i].direction-gfEye);

	vec3 lightVnorm = normalize(lightVector[i]);
	vec3 eyeVnorm = normalize(gfEyeCoordNormal);
	float light_cos = max(zero_float, dot(eyeVnorm, lightVnorm));
	float half_cos = dot(lightVnorm, normalize(halfVector[i]));

	if(lights[i].type == 2){
		//startof method 1

		float distance = length(lightDirection);
		float dotNormDir = max(dot(eyeVnorm, normalize(lightDirection)), zero_float);
		if(dotNormDir > 0.0){
			float att = 1.0 / (lights[i].attenuation.x + lights[i].attenuation.y * distance + lights[i].attenuation.z * distance * distance);
			lightColor += att * (gfDiffuseFactor * dotNormDir + (lights[i].color * lights[i].ambientIntensity));
			float dotNormHalf = max(dot(eyeVnorm, normalize(halfVector[i])),0.0);
			lightColor += att * gfLightSpecular * gfSpecularColor * pow(dotNormHalf, gfShininess);
		}
		lightColor.a = gfDiffuseColor.a;
		return lightColor;
	} else if(lights[i].position.w == zero_float || lights[i].type == 0){
		lightColor = gfDiffuseFactor * light_cos; 
		if (half_cos > zero_float){ 
			lightColor += (gfSpecularColor * gfLightSpecular) * pow(half_cos, gfShininess);
		}
		lightColor.a = gfDiffuseColor.a;
		return lightColor;
	}

	return vec4(zero_float);
}

void main() {
	//texturing vars
	vec2 texc;
	vec3 yuv, rgb;
	//endof

	//lighting
	int i;
	vec3 attemp;
	float distance = zero_float;
	vec4 lightColors[8];
	vec4 fragColor = vec4(0.0, 0.0, 0.0, 0.0);
	if(hasMeshColour){
		//fragColor = gfAmbientAndEmission;
		fragColor += m_colour;
	}

	//clippin
	if(hasClip){
		for(int i=0;i<CLIPS_MAX;i++){
			if(clipDistance[i]<0.0) discard;
		}
	}


	if (gfNumLights > 0) {

		for(i=0; i<8; i++){

			if(i>=gfNumLights) break;


			fragColor += doLighting(i);
		}
	}

	/* OLD colouring
	vec4 fragColor = gfAmbientAndEmission;
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
	ENDOF */

	fragColor = clamp(fragColor, zero_float, one_float);
	if(gfNumTextures>0){
		if(isYUV==1){
			texc = TexCoord.st;
			yuv.x = texture2D(y_plane, texc).r;
			yuv.y = texture2D(u_plane, texc).r;
			yuv.z = texture2D(v_plane, texc).r;
			yuv += offset;
			rgb.r = dot(yuv, R_mul);
			rgb.g = dot(yuv, G_mul);
			rgb.b = dot(yuv, B_mul);
			fragColor = vec4(rgb, alpha);
		}else {
			fragColor *= texture2D(y_plane, TexCoord);
		}}
	//if(hasMeshColour)fragColor=m_colour;	//TODO: delete
	gl_FragColor = fragColor;
}