Shader "Example/Normal Extrusion" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Amount ("Extrusion Amount", Range(-1, 1)) = 0.5
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200	
		Cull Off
		
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert

		#pragma target 3.0

		sampler2D _MainTex;
		float _Amount;

		struct Input {
			float2 uv_MainTex;
			float3 customColor;			
		};

		void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;            
		}
		
		void vert (inout appdata_full v) {
		    v.vertex.xyz += v.normal * _Amount;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
