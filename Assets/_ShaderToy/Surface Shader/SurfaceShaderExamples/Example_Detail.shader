Shader "Example/Detail" {
	Properties {	
		_MainTex ("Albedo (RGB)", 2D) = "white" {}		
		_BumpTex ("Bump (RGB)", 2D) = "bump" {}
		_DetailTex ("Detail (RGB)", 2D) = "gray" {}		
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _BumpTex;
		sampler2D _DetailTex;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float2 uv_DetailTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
			o.Albedo *= tex2D (_DetailTex, IN.uv_DetailTex).rgb * 2;
			o.Normal = UnpackNormal(tex2D (_BumpTex, IN.uv_BumpTex));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
