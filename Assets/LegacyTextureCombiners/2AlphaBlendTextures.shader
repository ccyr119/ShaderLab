Shader "LTC/2AlphaBlendTextures"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BlendTex ("Alpha Blended (RGBA)", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			// Apply base Texture
			SetTexture [_MainTex] { Combine texture }

			// Blend in the alpha texture using the lerp operator
			SetTexture [_BlendTex] { combine texture lerp (texture) previous }
		}
	}
}
