Shader "Blend/AlphaTest" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB) Transparency (A)", 2D) = "white" {}
		_Cutoff ("Alhpa Cutoff", Range(0,0.9)) = 0.5
		
	}
	SubShader {
		Tags { "RenderType"="TransparentCutout" 
		        "Queue"="AlphaTest" 
		        "IgnoreProjector"="True" }
		LOD 200
		
		Pass {
		    AlphaToMask On
            AlphaTest GEqual [_Cutoff]
            
            SetTexture [_MainTex] {
                combine texture * primary
            }
		}
	}
	FallBack "Diffuse"
}
