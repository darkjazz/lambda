uniform vec4 BaseColor;
uniform float MixRatio;

uniform samplerCube	EnvMap;

varying vec3	ReflectDir;
varying float	LightIntensity;

void main()
{
	vec4 envColor	= textureCube( EnvMap, ReflectDir ).rgba;
	
	vec4 base	= LightIntensity * BaseColor;
	envColor	= mix( envColor, base, MixRatio );
	
	gl_FragColor = envColor;
}