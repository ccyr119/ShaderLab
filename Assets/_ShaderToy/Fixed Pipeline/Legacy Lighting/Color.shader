Shader "ShaderToy/Color" {
	Properties{
		_ColorFront ("Color Tint", Color) = (1, 0, 0, 1)
		_ColorBack ("Color Tint", Color) = (0, 1, 0, 1)
	}

	SubShader {		
		Pass {
			Color [_ColorFront]			
		}

		Pass {
			Color [_ColorBack]
			Cull Front
		}
	}
}
