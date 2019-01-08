Shader "Example/DiffuseTexture/SimpleLambert" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf SimpleLambert
		
		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
		    half NdotL = max(0, dot(s.Normal, lightDir));
		    half4 c;
		    c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
		    c.a = s.Alpha;
		    return c;
		}

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
		    o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
