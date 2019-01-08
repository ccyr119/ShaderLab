Shader "Example/Detail/ScreenPos" {
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

        #pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpTex;
		sampler2D _DetailTex;
		float4 _DetailTex_ST;

		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpTex;
			float2 uv_DetailTex;
			float4 screenPos;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
			float2 screenUV = IN.screenPos.xy / IN.screenPos.w;
			screenUV *= _DetailTex_ST.xy;			
			o.Albedo *= tex2D (_DetailTex, screenUV).rgb * 2;
			o.Normal = UnpackNormal(tex2D (_BumpTex, IN.uv_BumpTex));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
