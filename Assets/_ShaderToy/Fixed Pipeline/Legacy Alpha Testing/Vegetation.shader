Shader "ShaderToy/Vegetation" {
	Properties {		
		_MainTex ("Base (RGB) Transparency (A)", 2D) = "white" {}
		_CutOff ("Alpha cutOff", Range(0, .9)) = .5
		_Color ("Main Color", Color) = (1,1,1,1)
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
        _Emission ("Emmisive Color", Color) = (0,0,0,0)
        _Shininess ("Shininess", Range (0.01, 1)) = 0.7        
	}
	SubShader {
		// Set up basic lighting
		Material {
				Diffuse [_Color]
                Ambient [_Color]
                Shininess [_Shininess]
                Specular [_SpecColor]
                Emission [_Emission]
			}
		Lighting On

		// Render both front and back facing polygons.
		Cull Off

		//first pass:
		//render any pixels that are more than [_CutOff] opaque
		Pass {			
			AlphaTest Greater [_CutOff]
			SetTexture [_MainTex] { combine texture * primary, texture }
		}

		// Second pass:
		// render in the semitransparent details.
		Pass {			
			// Don't write to the depth buffer
			ZWrite Off
			// Don't write pixels we have already written.
			ZTest Less
			// Only render pixels less or equal to the value.
			AlphaTest LEqual [_CutOff]

			// Set up alpha blending
			Blend SrcAlpha OneMinusSrcAlpha

			SetTexture [_MainTex] { combine texture * primary, texture }
		}
	}
	FallBack "Diffuse"
}
