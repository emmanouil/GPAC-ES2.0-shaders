#pragma STDGL invariant(all)	//delete after testing

#define CLIPS_MAX 		8

	uniform mat4 gfModelViewMatrix;
	uniform mat4 gfProjectionMatrix; 
	uniform mat4 gfNormalMatrix; 
	uniform vec4 gfEmissionColor; 
    uniform vec4 gfAmbientColor;
	uniform int gfNumLights;
    uniform vec4 gfLightPosition; 
    uniform vec4 gfLightAmbiant;
	uniform mat4 gfTextureMatrix;
	//uniform vec4 clipPlane;
	uniform vec4 clipPlane[CLIPS_MAX];	//we can put these two in a struct
	uniform bool clipActive[CLIPS_MAX];
	uniform bool hasClip;
	
	attribute vec4 gfVertex;
	attribute vec3 gfNormal;
	//test textu
	attribute vec4 gfMultiTexCoord;
	
	varying vec3 gfEyeCoordNormal;
	varying vec4 gfAmbientAndEmission;
	varying vec3 lightVector;
	varying vec3 halfVector;
	varying vec2 TexCoord;
	varying float clipDistance[CLIPS_MAX];
	
	void main(void)
	{
		gfEyeCoordNormal = normalize( vec3(gfNormalMatrix * vec4(gfNormal, 0.0)) );
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
		//if((gfTextureMatrix!=mat4(0.1)))
			TexCoord = vec2(gfTextureMatrix * gfMultiTexCoord);
		if(hasClip){
			for(int i=0;i<CLIPS_MAX;i++){
				clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;
			}
		}
		gl_Position = gfProjectionMatrix * (gfModelViewMatrix * gfVertex);
		//adding
	}