﻿Shader "Example/DiffuseTexture/SimpleLambert/Wrap" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf SimpleLambert
		
		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten) {
		    half NdotL = dot(s.Normal, lightDir);
		    half diff = max(0, NdotL * 0.5 + 0.5);
		    half4 c;
		    c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten);
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
