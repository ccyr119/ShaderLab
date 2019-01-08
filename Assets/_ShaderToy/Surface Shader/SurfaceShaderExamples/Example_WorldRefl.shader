﻿Shader "Example/WorldRefl" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Cube ("Cubemap", CUBE) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		#pragma target 3.0

		sampler2D _MainTex;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 0.5;
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}