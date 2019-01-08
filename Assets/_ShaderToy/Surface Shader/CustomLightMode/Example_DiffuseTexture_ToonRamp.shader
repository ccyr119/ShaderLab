Shader "Example/DiffuseTexture/ToonRamp" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Ramp ("Ramp (RGB)", 2D) = "gray" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Ramp
		
		sampler2D _Ramp;
		
		half4 LightingRamp(SurfaceOutput s, half3 lightDir, half atten) {
		    half NdotL = dot(s.Normal, lightDir);
		    half diff = NdotL * 0.5 + 0.5;
		    half3 ramp = tex2D(_Ramp, float2(diff, diff)).rgb;
		    half4 c;
		    c.rgb = s.Albedo * _LightColor0.rgb * ramp * atten;
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
