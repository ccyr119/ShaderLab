Shader "Transparent/DiffuseZWrite" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB) Tras (A)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "IgnoreProjector"="True" }
		LOD 200
		
//		Pass {
//		    ZWrite On
//		    ColorMask 0
//		}
//		
		UsePass "Transparent/Diffuse/FORWARD"
	}
	FallBack "Transparent/VertexLit"
}
