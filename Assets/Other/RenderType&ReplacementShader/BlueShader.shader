﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unlit/BlueShader"
{
	Properties
	{
		_Color("Color",Color) = (0,0,0,1)
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
			};

			struct v2f{
				float4 vertex : SV_POSITION;
			};

			fixed4 _Color ;

			v2f vert (appdata v){
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target{
				fixed4 col = _Color;
				return col;
			}
			ENDCG
		}
	}
}