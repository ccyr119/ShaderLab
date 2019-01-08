// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ARPG/DiffuseOnly"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
		_RimColor ("Rim Color", Color) = (0.7,0.7,0.7,0.7)
		_RimPower ("Rim Power", Range(0,1)) = 0		
		_SceneAlpha ("Alpha Power", Range(0,1)) = 1
	}

	SubShader
	{
		LOD 100

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "TransparentCutout"
		}
		
		Pass
		{
			//ZWrite Off
			Lighting Off
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
// Upgrade NOTE: excluded shader from DX11 and Xbox360; has structs without semantics (struct v2f members rim)
#pragma exclude_renderers xbox360
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			sampler2D _MainTex;
			half4 _MainTex_ST;
			half _RimPower;
			half _SceneAlpha;
			half4 _RimColor;

			struct v2f
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float3 LightingColor : TEXCOORD1;
			};

			v2f vert (appdata_full v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;
				
				half rim = max(_RimPower - max(dot(normalize(ObjSpaceViewDir(v.vertex)), v.normal), 0) ,0);
				o.LightingColor =  _RimColor.rgb * _RimColor.a * 2.0 * rim;
				return o;
			}

			half4 frag (v2f IN) : COLOR
			{
				half4 finalColor = tex2D(_MainTex, IN.texcoord);
				finalColor.rgb = finalColor + IN.LightingColor;
				finalColor.a = finalColor.a * _SceneAlpha;
				return finalColor;
			}
			ENDCG
		}
	}
}