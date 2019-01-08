Shader "ShaderToy/SetTexture_Self-illumination" {
	Properties {		
		_Color ("Color Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BlendTex ("Alpha Blended (RGBA)", 2D) = "white" {}
	}
	SubShader {		
//		UsePass "ShaderToy/2 Alpha Blended Textures/2_ALPHA_BLENDED_TEXTURE"
		
        Pass {
			// Set up basic _Color vertex lighting
			Material {
                Diffuse [_Color]
                Ambient [_Color]
				Shininess 0.7
            }
            Lighting On

			// Use texture alpha to blend up to white (= full illumination)
			SetTexture [_MainTex] {
				ConstantColor [_Color]
				combine constant lerp(texture) primary
			}

			 //Multiply in texture
			SetTexture [_MainTex] {				
				combine previous * texture
			}
		}
	}
	FallBack "Diffuse"
}
