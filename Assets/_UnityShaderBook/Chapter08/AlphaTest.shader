﻿Shader "USB/C8/AlphaTest" {
	Properties{
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo RGB", 2D) = "white" {}
		_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
	}

	SubShader {
		Tags {"RenderType"="TransparentCutout" "Queue"="AlphaTest" "IgnoreProjector"="True" "LightMode"="ForwardBase"}
		LOD 100

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
				float3 worldPos : TEXCOORD1;
				float2 uv : TEXCOORD2;
			};

			fixed4 _Color;
			fixed _Cutoff;
			sampler2D _MainTex;
			float4 _MainTex_ST;

			v2f vert(a2v v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.worldPos = UnityObjectToWorldNormal(v.normal);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				fixed3 worldNormal = normalize(i.worldNormal);
				fixed3 worldLightDir = UnityWorldSpaceLightDir(i.worldPos);
				fixed4 texColor = tex2D(_MainTex, i.uv);

				clip(texColor.a - _Cutoff);
				fixed3 albedo = texColor.rgb * _Color.rgb;
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
				fixed3 diffuse = _LightColor0.rgb * albedo * max(0, dot(worldNormal, worldLightDir));
				return fixed4(diffuse + ambient, 1.0);
			}

			ENDCG
		}
	}
}