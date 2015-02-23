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


struct material{
	vec4 ambient_color;
	vec4 diffuse_color;
	vec4 specular_color;
	vec4 emmisive_color;
	float shininess;
};

uniform vec4 gfAmbientColor; 
uniform vec4 gfDiffuseColor; 
uniform vec4 gfEmissionColor; 
uniform bool gfFogEnabled; 
uniform vec3 gfFogColor; 
uniform float gfFogDensity; 
uniform int gfFogType; 
uniform float gfFogVisibility; 
uniform vec4 gfLightAmbient; 
uniform vec4 gfLightDiffuse; 
uniform vec4 gfLightPosition; 
uniform vec4 gfLightSpecular; 
uniform mat4 gfModelViewMatrix;
uniform mat4 gfProjectionMatrix; 
uniform mat4 gfNormalMatrix; 
uniform int gfNumLights; 
uniform float gfShininess; 
uniform vec4 gfSpecularColor; 
uniform vec3 gfAttenuation; 
uniform vec3 gfPosition; 
uniform gfLight lights[LIGHTS_MAX];

attribute vec4 gfVertex;
attribute vec3 gfNormal;

varying vec3 gfEyeNormal;
varying vec4 gfAmbientAndEmission;
varying vec3 lightVector[8];
varying vec3 halfVector[8];
varying float gfFogFactor;
varying vec4 tmpEye;
varying vec3 normal[8];

varying vec4 gfDiffuseFactor;
varying vec4 gfAmbientFactor;

const float zero_float = 0.0;
const float one_float = 1.0;

vec3 eye;

	uniform vec4 clipPlane[CLIPS_MAX];
	uniform bool clipActive[CLIPS_MAX];
	varying float clipDistance[CLIPS_MAX];
	uniform bool hasClip;


float fog() {

	float fog, eyeDist = length(tmpEye-gfVertex);

	if(gfFogType==FOG_TYPE_LINEAR){
		fog= (gfFogVisibility-eyeDist)/gfFogVisibility;
	}else if(gfFogType==FOG_TYPE_EXP){
		fog= exp(-(tmpEye.z * gfFogDensity));
	}else if(gfFogType==FOG_TYPE_EXP2){
		fog= (tmpEye.z * gfFogDensity);
		fog = exp(-(fog * fog));
	}
	return clamp(fog, 0.0, 1.0);
}



void main(void)
{
	tmpEye = gfModelViewMatrix * gfVertex;
	gfEyeNormal = normalize( vec3(gfNormalMatrix * vec4(gfNormal, 0.0)) );
	vec3 att_dist;
	float att_factor;
	eye = vec3(0, 0, 1);


	gfAmbientAndEmission = gfAmbientColor + gfEmissionColor;
	gfAmbientAndEmission += gfLightAmbient * gfAmbientColor;


	gfDiffuseFactor = gfDiffuseColor * gfLightDiffuse;
	gfAmbientFactor = gfAmbientColor * gfLightAmbient;



	if (gfNumLights > 0) {

		for(int i=0; i<8; i++){

			if(i>=gfNumLights) break;

			if (gfLightPosition.w != float(0)) {
				lightVector[i] = lights[i].position.xyz - tmpEye.xyz;

				att_dist.x = 1.0;
				att_dist.z = dot(lightVector[i], lightVector[i]);
				att_dist.y = sqrt(att_dist.z);
				att_factor = 1.0 / dot(att_dist, lights[i].attenuation);
				lightVector[i] = normalize(lightVector[i]);

				float distance = length(lightVector[i]);
			} else {
			//if it is a directional light, position SHOULD indicate direction (modified implementation - check before commiting)
				lightVector[i] = lights[i].direction.xyz;
			}
			halfVector[i] = lightVector[i] + eye; 
		}
	}

	gfFogFactor = gfFogEnabled ? fog() : one_float;

				if(hasClip){
				for(int i=0;i<CLIPS_MAX;i++){
					clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;
					//or maybe this?
					//clipDistance[i] = clipActive[i] ? dot(gfVertex, clipPlane[i]) : 1.0;
				}
		}
	
	
	gl_Position = gfProjectionMatrix * tmpEye;
}