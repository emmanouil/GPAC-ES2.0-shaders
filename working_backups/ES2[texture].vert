#pragma STDGL invariant(all)	//delete after testing
	uniform mat4 gfModelViewMatrix;
	uniform mat4 gfProjectionMatrix; 
	uniform mat4 gfNormalMatrix; 
	uniform vec4 gfEmissionColor; 
    uniform vec4 gfAmbientColor;
	uniform int gfNumLights;
    uniform vec4 gfLightPosition; 
    uniform vec4 gfLightAmbiant;
	//test
	uniform mat4 gfTextureMatrix;
	
	attribute vec4 gfVertex;
	attribute vec3 gfNormal;
	//test textu
	attribute vec4 gfMultiTexCoord;
	
	varying vec3 gfEyeCoordNormal;
	varying vec4 gfAmbientAndEmission;
	varying vec3 lightVector;
	varying vec3 halfVector;
	varying vec2 TexCoord;
	
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
		gl_Position = gfProjectionMatrix * (gfModelViewMatrix * gfVertex);
		//adding
	}