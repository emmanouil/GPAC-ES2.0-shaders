/**
 * Shader implementing: Clipping, Texturing, Lighting
 * does NOT implement: Fog
 * TODO:	background
 *			material with/without lighting
 * Introduced: hasLights
 *
 **/

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
	float intensity;	//Diffuse
	float beamWidth;
	float cutOffAngle;
};

uniform vec4 gfLightDiffuse; 
uniform vec4 gfDiffuseColor; 
uniform vec4 gfLightAmbient; 
	uniform int gfNumTextures;
	uniform mat4 gfModelViewMatrix;
	uniform mat4 gfProjectionMatrix; 
	uniform mat4 gfNormalMatrix; 
	uniform vec4 gfEmissionColor; 
    uniform vec4 gfAmbientColor;
	uniform int gfNumLights;
    uniform vec4 gfLightPosition; 
    uniform vec4 gfLightAmbiant;
	uniform mat4 gfTextureMatrix;
	uniform gfLight lights[LIGHTS_MAX];
	//uniform vec4 clipPlane;
	uniform vec4 clipPlane[CLIPS_MAX];	//we can put these two in a struct
	uniform bool clipActive[CLIPS_MAX];
	uniform bool hasClip;
	uniform bool hasMeshColour;	//MESH_HAS_COLOR replaces the diffuse colour value of the material
	uniform bool enableLights;
	
	attribute vec4 gfVertex;
	attribute vec3 gfNormal;
	//test textu
	attribute vec4 gfMultiTexCoord;
	attribute vec4 gfMeshColour;
	
	varying vec3 gfEyeCoordNormal;
	varying vec4 gfEye;
	varying vec4 gfAmbientAndEmission;
	varying vec4 gfDiffuseFactor;
	varying vec4 gfAmbientFactor;
	//varying vec3 lightVector;
	//varying vec3 halfVector;
	varying vec2 TexCoord;
	varying float clipDistance[CLIPS_MAX];
	varying vec3 lightVector[8];
	varying vec3 halfVector[8];
	
	//testing material
	varying vec4 m_ambientC;
	varying vec4 m_diffuseC;
	varying vec4 m_specularC;
	varying vec4 m_emissionC;
	varying float m_shininess;	//a.ka. specular exponent
	varying vec4 m_colour;
//+ uniform bool hasMeshColour;
	
	void main(void)
	{
		gfEyeCoordNormal = normalize( vec3(gfNormalMatrix * vec4(gfNormal, 0.0)) );
		gfEye = gfModelViewMatrix * gfVertex;
		vec3 eye = vec3(0, 0, 1);	//import viewpoint (eye position) from tr_state
		
		gfAmbientAndEmission = gfAmbientColor + gfEmissionColor;
		gfAmbientAndEmission += gfLightAmbiant * gfAmbientColor;
		
		gfDiffuseFactor = gfDiffuseColor * gfLightDiffuse;
		//testing from here
		if(hasMeshColour){
			gfDiffuseFactor = gfMeshColour * gfLightDiffuse;
			m_colour = gfMeshColour;
		}
		//to here
		gfAmbientFactor = gfAmbientColor * gfLightAmbient;
		
		
	if (gfNumLights > 0) {

		for(int i=0; i<LIGHTS_MAX; i++){

			if(i>=gfNumLights) break;

			if (gfLightPosition.w != float(0)) {
				lightVector[i] = lights[i].position.xyz - gfEye.xyz;
				lightVector[i] = normalize(lightVector[i]);
				float distance = length(lightVector[i]);
			} else {
			//if it is a directional light, position SHOULD indicate direction (modified implementation - check before commiting)
				lightVector[i] = lights[i].direction.xyz;
			}
			halfVector[i] = lightVector[i] + eye; 
		}
	}		
		/*
		if (gfLightPosition.w != 0.0){ 
			lightVector = gfLightPosition.xyz - gfEye.xyz;
		} else {
			lightVector = gfLightPosition.xyz;
		}
		halfVector = lightVector + eye;
		*/
		
			if(gfNumTextures>0) TexCoord = vec2(gfTextureMatrix * gfMultiTexCoord);
		if(hasClip){
			for(int i=0;i<CLIPS_MAX;i++){
				clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;
			}
		}
		gl_Position = gfProjectionMatrix * gfEye;
		//adding
	}