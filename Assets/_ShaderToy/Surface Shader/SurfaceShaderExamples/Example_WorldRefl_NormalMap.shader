Shader "Example/WorldRefl/NormalMap" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpTex ("Bump (RGB)", 2D) = "bump" {}
		_Cube ("Cubemap", CUBE) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpTex;
		samplerCUBE _Cube;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float3 worldRefl;
			INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb * 0.5;
			o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
			o.Emission = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
