#version 140
#pragma STDGL invariant(all)	//delete after testing
#define CLIPS_MAX 		8
	uniform mat4 gfModelViewMatrix;
	uniform mat4 gfProjectionMatrix; 
	uniform mat4 gfNormalMatrix; 
	uniform vec4 gfEmissionColor; 
    uniform vec4 gfAmbientColor;
    uniform vec4 gfLightPosition; 
    uniform vec4 gfLightAmbiant;
	//test
	uniform mat4 gfTextureMatrix;
	/*
	attribute vec4 gfVertex;
	attribute vec3 gfNormal;
	attribute vec4 gfMultiTexCoord;
	
	varying vec3 gfEyeCoordNormal;
	varying vec4 gfAmbientAndEmission;
	varying vec3 lightVector;
	varying vec3 halfVector;
	varying vec2 TexCoord;
	*/
	in vec4 gfVertex;
	in vec3 gfNormal;
	in vec4 gfMultiTexCoord;
	
	out vec3 gfEyeCoordNormal;
	out vec4 gfAmbientAndEmission;
	out vec3 lightVector;
	out vec3 halfVector;
	out vec2 TexCoord;
	
	
	uniform vec4 clipPlane[CLIPS_MAX];
	uniform bool clipActive[CLIPS_MAX];
	//varying float clipDistance[CLIPS_MAX];
	out float clipDistance[CLIPS_MAX];
	uniform bool hasClip;
	
	void main(void)
	{
		gfEyeCoordNormal = vec3(gfNormalMatrix * gfNormal);
		vec3 vpos = vec3(gfModelViewMatrix * gfVertex);
		vec3 eye = normalize(-vpos.xyz);
		eye = vec3(0, 0, 1);
		gfAmbientAndEmission = gfAmbientColor + gfEmissionColor;
		gfAmbientAndEmission += gfLightAmbiant * gfAmbientColor;
		if (gfLightPosition.w != 0.0){ 
			lightVector = gfLightPosition.xyz - vpos.xyz;
		} else {
			lightVector = gfLightPosition.xyz;
		}
		halfVector = lightVector + eye;
			TexCoord = vec2(gfTextureMatrix * gfMultiTexCoord);
			if(hasClip){
				for(int i=0;i<CLIPS_MAX;i++){
					clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;
					//or maybe this?
					//clipDistance[i] = clipActive[i] ? dot(gfVertex, clipPlane[i]) : 1.0;
				}
		}
		gl_Position = gfProjectionMatrix * (gfModelViewMatrix * gfVertex);
	}