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
		
		VPpli = normalize(VPpli);
		
		ndotl = max(0.0, dot(n, VPpli));
		color_out += (ndotl * lights[i].color * gfDiffuseColor);
		h_vec = normalize(VPpli + p_eye.xyz);
		ndoth = dot(n, h_vec);
		if(ndoth > 0.0){
			color_out += (pow(ndoth, gfShininess) * gfSpecularColor * lights[i].color);
		}
		color_out *= att_factor;

	}
	
	return color_out;

}


vec4 do_lighting(){
	vec4 vtx_color;
	int i,j;
	vtx_color = vec4(0.0, 0.0, 0.0, 0.0);
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
	
}