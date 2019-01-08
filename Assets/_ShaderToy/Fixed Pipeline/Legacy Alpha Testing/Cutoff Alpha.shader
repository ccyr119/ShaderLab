Shader "ShaderToy/Cutoff Alpha" {
	Properties {		
		_MainTex ("Base (RGB) Transparency (A)", 2D) = "white" {}
		_CutOff ("Alpha cutOff", Range(0, 1)) = 0.5
		_Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
        _Emission ("Emmisive Color", Color) = (0,0,0,0)
        _Shininess ("Shininess", Range (0.01, 1)) = 0.7        
	}
	SubShader {
		Pass {
		   
		    AlphaToMask On
			// Use the Cutoff parameter defined above to determine
            // what to render.
			AlphaTest Greater [_CutOff]
			Material {
				Diffuse [_Color]
                Ambient [_Color]
                Shininess [_Shininess]
                Specular [_SpecColor]
                Emission [_Emission]
			}
			Lighting On

			SetTexture [_MainTex] { combine texture * primary }
		}
	}
	FallBack "Diffuse"
}
