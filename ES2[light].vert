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
uniform vec4 gfSpecularColor; 
uniform float gfShininess;
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
	
	
varying vec4 colour;
vec4 p_eye, ambient, diffuse;
vec3 n;

vec4 lighting_e(int i){
	vec4 color_out = vec4(0.0, 0.0, 0.0, 0.0);
	vec3 h_vec, VPpli;;
	float ndotl, ndoth, att_factor = 1.0;
	
	if(lights[i].position != 0.0){
		float spot_factor;
		vec3 att_dist;
		
		VPpli = lights[i].position.xyz - p_eye.xyz;
		float distance = length(VPpli);
		
		att_factor = 1.0 / (lights[i].attenuation.x + (lights[i].attenuation.y * distance) + (lights[i].attenuation.z * distance * distance));
		
		/*
		//TRY WITH ATTENTION SET!!
		if(lights[i].type > 0){
			att_dist.x = 1.0;
			att_dist.z = dot(VPpli, VPpli);	//check
			att_dist.y = sqrt(att_dist.z);
			att_factor = 1.0 / dot(att_dist, lights[i].attenuation);
		}
				*/
		VPpli = normalize(VPpli);
		
		color_out += m_colour;
		ndotl = max(0.0, dot(n, VPpli));
		color_out += (ndotl * lights[i].color * gfDiffuseColor);
		h_vec = normalize(VPpli + vec3(0.0, 0.0, 0.1));
		ndoth = dot(n, h_vec);
		if(ndoth > 0.0){
			color_out += (pow(ndoth, gfShininess) * gfSpecularColor * lights[i].color);
		}
		color_out *= att_factor;
		
		//TEXTBOOK
		/*
		if(lights[i].cutOffAngle<180.0){	//check for spot - might be in rad
			spot_factor = dot(-VPpli, lights[i].direction.xyz);	//direction xyz
			if(spot_factor >= cos(radians(lights[i].cutOffAngle))){	//check for spot
				spot_factor = pow(spot_factor, lights[i].beamWidth);	//check for spot (beamWidth)
			}else{
				spot_factor = 0.0;
			}
			att_factor *= spot_factor;
		}else{		//else directional
			VPpli = lights[i].position.xyz;
		}
		
		if(att_factor > 0.0){
		
			color_out = vec4(1.0, 1.0, 1.0, 1.0);
		
		}*/

	}
	
	return color_out;
	
		/*
				vec3 att_dist = vec3(1.0, 0.0, 0.0);
		vec3 VPpli = lights[i].position.xyz - gfEye.xyz;
		att_dist.z = dot(VPpli, VPpli);	//check
		att_dist.y = sqrt(att_dist.z);
		float att = 1.0 / dot(att_dist, lights[i].attenuation);
		VPpli = normalize(VPpli);
		float spot = dot(-VPpli, lights[i].direction.xyz);
		if(spot>=cos(radians(lights[i].cutOffAngle))){
			spot = pow(spot, lights[i].beamWidth);
		}else{
			spot = 0.0;
		}
		att *= spot;
		if(att>0.0){
			lightColor += (lights[i].color*gfAmbientColor);
			float ndotl = max(0.0, dot(gfEyeCoordNormal, VPpli));
			lightColor += (ndotl * gfLightDiffuse * gfDiffuseColor);
			vec3 h_vec = normalize(VPpli + vec3(0.0, 0.0, 0.0));
			float ndoth = dot(gfEyeCoordNormal, h_vec);
			if(ndoth>0.0){
				lightColor += (pow(ndoth, gfShininess) * gfSpecularColor * gfLightSpecular);
				lightColor *= att;
			
			}
		
		
		}*/
		
		
		
		
		
		
		
		
		
		



}


vec4 do_lighting(){
	vec4 vtx_color;
	int i,j;
	vtx_color = m_colour;
	j = 0;
	for( i =0; i<LIGHTS_MAX; i++){
		if(j>=gfNumLights)
			break;
			
		vtx_color += lighting_e(i);
		
		j++;
	}
	
	vtx_color.a = gfDiffuseColor.a;
	
	return vtx_color;

}


void main(void)
{
	int i, j;
	
	p_eye = gfModelViewMatrix * gfVertex;
	
	mat3 normM;
	normM[0] = gfNormalMatrix[0].xyz;
	normM[1] = gfNormalMatrix[1].xyz;
	normM[2] = gfNormalMatrix[2].xyz;
	n = normM * gfNormal.xyz;
	
	//check
	n = normalize(n);
	
	colour = do_lighting();

	gl_Position = gfProjectionMatrix * p_eye;
	
			/*
		mat3 normM;
		normM[0] = gfNormalMatrix[0].xyz;
		normM[1] = gfNormalMatrix[1].xyz;
		normM[2] = gfNormalMatrix[2].xyz;
		gfEyeCoordNormal = normM * gfNormal;
		*/
	
	
			/*
		if (gfLightPosition.w != 0.0){ 
			lightVector = gfLightPosition.xyz - gfEye.xyz;
		} else {
			lightVector = gfLightPosition.xyz;
		}
		halfVector = lightVector + eye;
		*/
	
	
	
}	
	
	//ATTENTION!!!!
	/*
	void main(void)
	{
		gfEyeCoordNormal = normalize( vec3(gfNormalMatrix * vec4(gfNormal, 0.0)) );
		
		gfEye = gfModelViewMatrix * gfVertex;
		vec3 eye = gfEye.xyz;	//import viewpoint (eye position) from tr_state
		
		gfAmbientAndEmission = gfAmbientColor + gfEmissionColor;
		gfAmbientAndEmission += gfLightAmbient * gfAmbientColor;
		
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

		
			if(gfNumTextures>0) TexCoord = vec2(gfTextureMatrix * gfMultiTexCoord);
		if(hasClip){
			for(int i=0;i<CLIPS_MAX;i++){
				clipDistance[i] = clipActive[i] ? dot(gfVertex.xyz, clipPlane[i].xyz) + clipPlane[i].w : 1.0;
			}
		}
		gl_Position = gfProjectionMatrix * gfEye;
		//adding
	}
	*/