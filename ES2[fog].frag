//TODO Fog - too fast

#define FOG_TYPE_LINEAR 0
#define FOG_TYPE_EXP    1
#define FOG_TYPE_EXP2   2

#define L_DIRECTIONAL	0
#define L_SPOT		    1
#define L_POINT			2

#define LIGHTS_MAX 		8
#define TEXTURES_MAX 	2

#define CLIPS_MAX 		8

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
uniform bool gfFogEnabled; 
uniform vec3 gfFogColor; 
uniform float gfShininess; 
uniform int gfNumLights; 
uniform vec4 gfLightPosition; 
uniform vec4 gfLightDiffuse; 
uniform vec4 gfLightSpecular; 
uniform vec3 gfAttenuation; 
uniform vec3 gfPosition; 
uniform gfLight lights[LIGHTS_MAX];

varying vec3 gfEyeNormal;
varying vec4 gfAmbientAndEmission;
varying vec3 lightVector[8];
varying vec3 halfVector[8];
varying float gfFogFactor;
varying vec4 gfDiffuseFactor;
varying vec4 gfAmbientFactor;
varying vec4 tmpEye;

const float zero_float = 0.0;
const float one_float = 1.0;

	uniform vec4 clipPlane[CLIPS_MAX];
	uniform bool clipActive[CLIPS_MAX];
	varying float clipDistance[CLIPS_MAX];
	uniform bool hasClip;



vec4 doLighting(int i){

//instead of vec4 lightColor = gfAmbientAndEmission;
	vec4 lightColor = vec4(zero_float, zero_float, zero_float, zero_float);

	vec3 lightDirection = vec3(lights[i].position-tmpEye);
	//check the way position & direction are handled according to type
	if(lights[i].type == 0)
		lightDirection = vec3(lights[i].direction-tmpEye);

	vec3 lightVnorm = normalize(lightVector[i]);
	vec3 eyeVnorm = normalize(gfEyeNormal);
	float light_cos = max(zero_float, dot(eyeVnorm, lightVnorm));
	float half_cos = dot(lightVnorm, normalize(halfVector[i]));

	if(lights[i].type == 2){
	//startof method 1
		
		float distance = length(lightDirection);
		float dotNormDir = max(dot(eyeVnorm, normalize(lightDirection)), zero_float);
		if(dotNormDir > 0.0){
			float att = 1.0 / (lights[i].attenuation.x + lights[i].attenuation.y * distance + lights[i].attenuation.z * distance * distance);
			lightColor += att * ((gfLightDiffuse * gfDiffuseColor) * dotNormDir + (lights[i].color * lights[i].ambientIntensity));
			float dotNormHalf = max(dot(eyeVnorm, normalize(halfVector[i])),0.0);
			lightColor += att * gfLightSpecular * gfSpecularColor * pow(dotNormHalf, gfShininess);
		}
		/*
		float att = 1.0 / (lights[i].attenuation.x + lights[i].attenuation.y * distance + lights[i].attenuation.z * distance * distance);
		lightColor += att * (gfLightDiffuse * gfDiffuseColor) * light_cos; 
		if (half_cos > zero_float){ 
			lightColor += att * (gfSpecularColor * gfLightSpecular) * pow(half_cos, gfShininess);
		}
		*/
	//startof method 2
	/*
		testVec.x = 1.0;
		testVec.z = dot(lightDirection, lightDirection);
		testVec.y = sqrt(testVec.z);
		float att = 1.0 / dot(testVec, lights[i].attenuation);
		*/
	//endof (delete vars like testVec)
		lightColor.a = gfDiffuseColor.a;
		return lightColor;
	} else if(lights[i].position.w == zero_float || lights[i].type == 0){
		lightColor = (gfLightDiffuse * gfDiffuseColor) * light_cos; 
		if (half_cos > zero_float){ 
			lightColor += (gfSpecularColor * gfLightSpecular) * pow(half_cos, gfShininess);
		}
		lightColor.a = gfDiffuseColor.a;
		return lightColor;
	}

	return vec4(zero_float);
}





void main() {
	int i;
	vec3 attemp;
	float distance = zero_float;
	vec4 lightColors[8];
	vec4 fragColor = vec4(0.0, 0.0, 0.0, 0.0);
	
		if(hasClip){
		for(int i=0;i<CLIPS_MAX;i++){
			if(clipDistance[i]<0.0) discard;
		}
	}

	if (gfNumLights > 0) {

		for(i=0; i<8; i++){

			if(i>=gfNumLights) break;


			fragColor = +doLighting(i);
		}
	}
	fragColor = clamp(fragColor, zero_float, one_float);
	if(gfFogEnabled)
		fragColor = fragColor * gfFogFactor + vec4(gfFogColor, zero_float) * (one_float - gfFogFactor);
	gl_FragColor = fragColor;
}