Shader "ShaderToy/UsePassName" {
	Properties {
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BlendTex ("Alpha Blended (RGBA)", 2D) = "white" {}
	}
	SubShader {
		UsePass "ShaderToy/2 Alpha Blended Textures/2_ALPHA_BLENDED_TEXTURE"		
	}
	FallBack "Diffuse"
}
