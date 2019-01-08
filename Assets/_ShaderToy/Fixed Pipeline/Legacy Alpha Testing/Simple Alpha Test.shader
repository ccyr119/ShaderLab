Shader "ShaderToy/Simple Alpha Test" {
	Properties {		
		_MainTex ("Base (RGB) Transparency (A)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Pass {
			// Only render pixels with an alpha larger than _Cutoff
			AlphaTest Greater [_Cutoff]
			SetTexture [_MainTex] { Combine texture }
		}
	}
	FallBack "Diffuse"
}
