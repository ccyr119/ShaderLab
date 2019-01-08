Shader "ShaderToy/Material" {
	Properties{
		//_ColorFront ("Color Tint", Color) = (1, 0, 0, 1)
		//_ColorBack ("Color Tint", Color) = (0, 1, 0, 1)
		_Diffuse ("Diffuse Color", Color) = (1, 0, 0, 1)
		_Ambient ("Ambient Color", Color) = (0, 0, 1, 1)
		_Shininess ("Shininess Number", Range(0, 1)) = 0.7
		_SpecColor ("Specular Color", Color) = (1, 1, 0, 1)
		_Emission ("Emission Color", Color) = (0, 0.4, 0, 1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	SubShader {
		Material {
			Diffuse [_Diffuse]
            Ambient [_Ambient]  // 需要Shininess 和 Ambient 同时设置，不然会黑屏
            Shininess [_Shininess] // 需要Shininess 和 Ambient 同时设置，不然会黑屏
            Specular [_SpecColor]  
            Emission [_Emission]
		}

		//ColorMaterial AmbientAndDiffuse

		Pass {
			Lighting On
			SeparateSpecular On		
			SetTexture [_MainTex] {
                Combine texture * primary DOUBLE, texture * primary
            }
		}
	}
}
