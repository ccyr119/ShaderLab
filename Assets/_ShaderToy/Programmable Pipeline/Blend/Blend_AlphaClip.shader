Shader "Blend/AlphaClip" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB) Transparency (A)", 2D) = "white" {}
		_Cutoff ("Alhpa Cutoff", Range(0,1)) = 0.5
		
	}
	SubShader {
		Tags { "RenderType"="TransparentCutout" 
		        "Queue"="AlphaTest" 
		        "IgnoreProjector"="True" }
		LOD 200
		AlphaToMask On		
				
		CGPROGRAM		
		#pragma surface surf Lambert


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Cutoff;		
		fixed4 _Color;
		
		void surf (Input IN, inout SurfaceOutput o) {		    
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			clip(c.a - _Cutoff);
			o.Albedo.rgb = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
