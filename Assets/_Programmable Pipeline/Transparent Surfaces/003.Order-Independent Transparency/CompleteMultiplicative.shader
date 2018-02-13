// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CG/Transparent Surfaces/CompleteMultiplicative"
{
	Properties {
		_Opacity ("Opacity", Range(0, 1)) = 0.2
	}

	SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn

		Cull Off // draw front and back faces
		ZWrite Off // don't write to depth buffer

		Pass { 
          
		// in order not to occlude other objects
		Blend Zero OneMinusSrcAlpha // multiplicative blending 
		// for attenuation by the fragment's alpha

		CGPROGRAM 
 
		#pragma vertex vert 
		#pragma fragment frag

		uniform float _Opacity;
 
		float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
		{
			return UnityObjectToClipPos(vertexPos);
		}
 
		float4 frag(void) : COLOR 
		{
			return float4(1.0, 0.0, 0.0, _Opacity); 
		}
 
		ENDCG  
		}

		Pass {        
		// in order not to occlude other objects
		Blend SrcAlpha One // multiplicative blending 
		// for attenuation by the fragment's alpha

		CGPROGRAM 
 
		#pragma vertex vert 
		#pragma fragment frag

		uniform float _Opacity;
 
		float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
		{
			return UnityObjectToClipPos(vertexPos);
		}
 
		float4 frag(void) : COLOR 
		{
			return float4(1.0, 0.0, 0.0, _Opacity); 
		}
 
		ENDCG  
		}
   }
}
