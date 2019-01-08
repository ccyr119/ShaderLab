Shader "Blend/SimpleAdditive" {
	Properties {		
		_MainTex ("Texture to blend(RGBA)", 2D) = "black" {}
		_Cutoff ("Alhpa Cutoff", Range(0,0.9)) = 0.5		
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }		
		
		Pass {
		    AlphaTest GEqual [_Cutoff]
		    Blend One One
		    
		    SetTexture [_MainTex] {
		        combine texture
		    }
		}
	}
	FallBack "Diffuse"
}
