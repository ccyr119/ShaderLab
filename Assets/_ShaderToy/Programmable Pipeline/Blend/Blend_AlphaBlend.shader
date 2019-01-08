Shader "Blend/AlphaBlend" {
	Properties {
	    _MainTex ("Base (RGB) Transparency(A)", 2D) = "white" {}
	    _Color ("Main Color", Color) = (1, 1, 1, 1)
	    _BlendSrcFactor ("Blend SrcFactor", Float) = 5
	    _BlendDstFactor ("Blend DestFactor", Float) = 10
	}
	
	SubShader {
	    Tags { "RenderType" = "Transparent" 
	            "Queue" = "Transparent" 
	            "IgnoreProjector" = "True"}
	    
	    
	    Pass {
	        ZWrite off
	        Blend [_BlendSrcFactor] [_BlendDstFactor]
	        
	        SetTexture [_MainTex] {
	            ConstantColor [_Color]
	            combine texture * constant
	        }
	    }
	}
}
