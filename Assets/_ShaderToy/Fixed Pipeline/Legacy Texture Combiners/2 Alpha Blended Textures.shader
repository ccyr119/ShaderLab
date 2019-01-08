Shader "ShaderToy/2 Alpha Blended Textures" {
	Properties {		
		_Color ("Color Tint", Color) = (0.5, 0.5, 0.5, 1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BlendTex ("Alpha Blended (RGBA)", 2D) = "white" {}
	}
	SubShader {
		Pass {
		    Name "2_ALPHA_BLENDED_TEXTURE"
		    
			SetTexture [_MainTex] {
				ConstantColor [_Color]
				combine texture * Constant + Constant
			}

			SetTexture [_BlendTex] {				
				combine texture lerp (texture) previous
			}
		}
	}
	FallBack "Diffuse"
}
