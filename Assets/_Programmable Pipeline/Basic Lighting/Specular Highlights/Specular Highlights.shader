Shader "CG/Basic Lighting/Specular Highlights"
{
	Properties
	{
		_Color ("Diffuse Material Color", Color) = (1, 1, 1, 1)
		_SpecColor ("Specular Material Color", Color) = (1, 1, 1, 1)
		_Shininess ("Shininess", Float) = 10
	}
	SubShader
	{
		Pass
		{
			Tags { "LightMode"="ForwardBase" }
				// pass for ambient light and first light source		

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			
			#include "UnityCG.cginc"
			uniform float4 _LightColor0;
				// color of light source (from "Lighting.cginc")

			// User-specified Properties
			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{	
				float4 pos : SV_POSITION;
				float4 col : COLOR;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;
				float4x4 modelMatrix = unity_ObjectToWorld;
				float3x3 modelMatrixInverse = unity_WorldToObject;

				float3 normalDirection = normalize(mul(input.normal, modelMatrixInverse));
				float3 viewDirection = normalize(_WorldSpaceCameraPos - mul(modelMatrix, input.vertex).xyz);

				float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - mul(modelMatrix, input.vertex * _WorldSpaceLightPos0.w).xyz;
				float one_over_distance =  1.0 / length(vertexToLightSource);
				float attenuation = lerp(1.0, one_over_distance, _WorldSpaceLightPos0.w);
				float3 lightDirection = vertexToLightSource * one_over_distance;

				float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb;
				float3 diffuseReflection = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));
				float3 specularReflection;
				if (dot(normalDirection, lightDirection) < 0.0) // light source on the wrong side?
				{
					specularReflection = float3(0.0, 0.0, 0.0);
				}
				else // light source on the right side
				{
					specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * pow(
						max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
				}

				output.col = float4(ambientLighting + diffuseReflection + specularReflection, 1.0) ;
				output.pos = UnityObjectToClipPos(input.vertex);

				return output;
			}
						
			float4 frag (vertexOutput input) : COLOR
			{	
				return input.col;
			}
			ENDCG
		}

		Pass
		{
			Tags { "LightMode"="ForwardAdd" }
				// pass for ambient light and first light source		
			Blend One One // additive blending

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			
			#include "UnityCG.cginc"
			uniform float4 _LightColor0;
				// color of light source (from "Lighting.cginc")

			// User-specified Properties
			uniform float4 _Color;
			uniform float4 _SpecColor;
			uniform float _Shininess;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct vertexOutput
			{	
				float4 pos : SV_POSITION;
				float4 col : COLOR;
			};

			vertexOutput vert (vertexInput input)
			{
				vertexOutput output;
				float4x4 modelMatrix = unity_ObjectToWorld;
				float3x3 modelMatrixInverse = unity_WorldToObject;

				float3 normalDirection = normalize(mul(input.normal, modelMatrixInverse));
				float3 viewDirection = normalize(_WorldSpaceCameraPos - mul(modelMatrix, input.vertex).xyz);

				float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - mul(modelMatrix, input.vertex * _WorldSpaceLightPos0.w).xyz;
				float one_over_distance =  1.0 / length(vertexToLightSource);
				float attenuation = lerp(1.0, one_over_distance, _WorldSpaceLightPos0.w);
				float3 lightDirection = vertexToLightSource * one_over_distance;

				float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb;
				float3 diffuseReflection = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));
				float3 specularReflection;
				if (dot(normalDirection, lightDirection) < 0.0) // light source on the wrong side?
				{
					specularReflection = float3(0.0, 0.0, 0.0);
				}
				else // light source on the right side
				{
					specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * pow(
						max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
				}

				output.col = float4(ambientLighting + diffuseReflection + specularReflection, 1.0) ;
				output.pos = UnityObjectToClipPos(input.vertex);

				return output;
			}
						
			float4 frag (vertexOutput input) : COLOR
			{	
				return input.col;
			}
			ENDCG
		}
	}

	FallBack "Specular"
}
