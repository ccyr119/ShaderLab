Shader "Example/DiffuseBump" {
	Properties {	
		_MainTex ("Albedo (RGB)", 2D) = "white" {}		
		_BumpTex ("Bump (RGB)", 2D) = "bump" {}		
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal(tex2D (_BumpTex, IN.uv_BumpTex));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
